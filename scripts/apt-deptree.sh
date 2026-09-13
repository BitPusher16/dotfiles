#!/usr/bin/env bash
# ASCII dependency tree of installed APT packages.
#
# grok convo:
# https://grok.com/c/ef99f258-3095-4c46-a3ad-3c23a61adc54?rid=42262d07-1fa9-4b20-afd0-0aafe2f13fd1
# https://grok.com/share/bGVnYWN5_07d2c389-e5a1-4719-a8a6-747106fbfaeb
#
# Hard Depends/Pre-Depends only. Built from one dpkg-query, not per-package
# apt-cache. Shared deps / cycles marked with *.
#
#   apt-deptree.sh                 # roots = apt-mark showmanual
#   apt-deptree.sh firefox vim
#   apt-deptree.sh --all
#   apt-deptree.sh -d 3 bash | less

set -o pipefail
export LC_ALL=C

BOX_MID='├── '
BOX_END='└── '
BOX_PAD='│   '
BOX_EMP='    '

DEPTH=8
ALL=0
ROOTS=()

cleanup() {
  trap - INT PIPE TERM
  exit "${1:-0}"
}
trap 'cleanup 130' INT
trap 'cleanup 0' PIPE
trap 'cleanup 143' TERM

emit() { printf '%s\n' "$1" || cleanup 0; }

usage() {
  cat <<'EOF'
Usage: apt-deptree.sh [options] [package...]
  -d, --depth N   max recursion depth (default: 8)
  --all           use every installed package as a root
  -h, --help      this help
  * = already shown above (shared dependency or cycle)
EOF
}

while (( $# )); do
  case $1 in
    -d|--depth)
      [[ -n ${2-} && $2 != -* ]] || { emit "missing argument for $1"; cleanup 2; }
      DEPTH=$2
      shift 2
      ;;
    --all) ALL=1; shift ;;
    -h|--help) usage; cleanup 0 ;;
    --) shift; ROOTS+=("$@"); break ;;
    -*) emit "unknown option: $1"; usage; cleanup 2 ;;
    *) ROOTS+=("$1"); shift ;;
  esac
done

declare -A INSTALLED=()
declare -A SEEN=()
declare -A DEP_CACHE=()

# Split a Depends/Pre-Depends field into unique package names.
# "libc6 (>= 2.34), mawk | awk" -> libc6, mawk
parse_dep_field() {
  local field=$1
  local item alt name
  local -A seen_dep=()
  local -a out=()

  field=${field//, /$'\n'}
  field=${field//,/$'\n'}
  while IFS= read -r item; do
    item=${item#"${item%%[![:space:]]*}"}
    item=${item%"${item##*[![:space:]]}"}
    [[ -n $item ]] || continue
    alt=${item%%|*}
    alt=${alt#"${alt%%[![:space:]]*}"}
    name=${alt%%[[:space:](]*}
    name=${name#<}
    name=${name%>}
    name=${name%%:*}
    [[ -n $name ]] || continue
    if [[ ! -v seen_dep[$name] ]]; then
      seen_dep["$name"]=1
      out+=("$name")
    fi
  done <<< "$field"

  if ((${#out[@]})); then
    local IFS=$'\n'
    printf '%s\n' "${out[*]}"
  fi
}

# One dpkg-query for the whole installed set + every hard dep list.
while IFS=$'\t' read -r pkg depends predepends; do
  [[ -n $pkg ]] || continue
  INSTALLED["$pkg"]=1
  DEP_CACHE["$pkg"]=$(parse_dep_field "${depends:+$depends, }${predepends}")
done < <(dpkg-query -W -f='${Package}\t${Depends}\t${Pre-Depends}\n' 2>/dev/null)

if ((${#ROOTS[@]})); then
  :
elif (( ALL )); then
  while IFS= read -r pkg; do
    [[ -n $pkg ]] && ROOTS+=("$pkg")
  done < <(printf '%s\n' "${!INSTALLED[@]}" | sort)
else
  while IFS= read -r pkg; do
    [[ -n $pkg ]] && ROOTS+=("$pkg")
  done < <(apt-mark showmanual 2>/dev/null)
fi

# walk pkg prefix is_last depth
walk() {
  local pkg=$1 prefix=$2 is_last=$3 depth=$4
  local mark='' branch child_prefix
  local -a children=()
  local i last

  if [[ -v SEEN[$pkg] ]]; then
    mark=' *'
  elif [[ ! -v INSTALLED[$pkg] ]]; then
    mark=' (not installed)'
  fi

  if (( is_last )); then
    branch=$BOX_END
  else
    branch=$BOX_MID
  fi
  emit "${prefix}${branch}${pkg}${mark}"

  if [[ -v SEEN[$pkg] || ! -v INSTALLED[$pkg] || depth -ge DEPTH ]]; then
    return
  fi
  SEEN["$pkg"]=1

  if [[ -n ${DEP_CACHE[$pkg]} ]]; then
    mapfile -t children <<< "${DEP_CACHE[$pkg]}"
  fi

  if (( is_last )); then
    child_prefix="${prefix}${BOX_EMP}"
  else
    child_prefix="${prefix}${BOX_PAD}"
  fi

  last=$(( ${#children[@]} - 1 ))
  for i in "${!children[@]}"; do
    [[ -n ${children[i]} ]] || continue
    if (( i == last )); then
      walk "${children[i]}" "$child_prefix" 1 $((depth + 1))
    else
      walk "${children[i]}" "$child_prefix" 0 $((depth + 1))
    fi
  done
}

emit "# roots: ${#ROOTS[@]}   installed: ${#INSTALLED[@]}   depth≤${DEPTH}"
emit "# * = already shown above (shared / cycle)"
emit "."

last=$(( ${#ROOTS[@]} - 1 ))
for i in "${!ROOTS[@]}"; do
  root=${ROOTS[i]}
  mark=''
  if [[ -v SEEN[$root] ]]; then
    mark=' *'
  elif [[ ! -v INSTALLED[$root] ]]; then
    mark=' (not installed)'
  fi
  if (( i == last )); then
    emit "${BOX_END}${root}${mark}"
    child_prefix=$BOX_EMP
  else
    emit "${BOX_MID}${root}${mark}"
    child_prefix=$BOX_PAD
  fi
  if [[ -v SEEN[$root] || ! -v INSTALLED[$root] ]]; then
    continue
  fi
  SEEN["$root"]=1
  children=()
  if [[ -n ${DEP_CACHE[$root]} ]]; then
    mapfile -t children <<< "${DEP_CACHE[$root]}"
  fi
  clast=$(( ${#children[@]} - 1 ))
  for j in "${!children[@]}"; do
    [[ -n ${children[j]} ]] || continue
    if (( j == clast )); then
      walk "${children[j]}" "$child_prefix" 1 1
    else
      walk "${children[j]}" "$child_prefix" 0 1
    fi
  done
done

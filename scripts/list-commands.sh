#!/usr/bin/env bash
# List aliases, functions, builtins, keywords, and PATH commands,
# plus which help system(s) know about each name.
#
# grok convo:
# https://grok.com/c/ef99f258-3095-4c46-a3ad-3c23a61adc54?rid=42262d07-1fa9-4b20-afd0-0aafe2f13fd1
# https://grok.com/share/bGVnYWN5_07d2c389-e5a1-4719-a8a6-747106fbfaeb
#
# Usage:
#   ./list-commands.sh
#   ./list-commands.sh | less
#   ./list-commands.sh > commands.txt
#
# HELP column tags (how to open docs for that name — not extra PATH commands)
#
#   help       bash builtin, or a keyword bash documents via `help`
#              -> help printf
#
#   man        a man page exists for this name
#              -> man ls
#
#   info       a GNU Info document exists
#              -> info ls
#
#   man bash   no standalone page; documented as shell syntax
#              -> man bash    (search RESERVED WORDS / Compound Commands / [[)
#
#   alias      this name is an alias in the current shell
#              -> alias NAME
#
#   type       ask the shell what the name currently resolves to
#              -> type NAME
#
#   declare    this name is a shell function
#              -> declare -f NAME
#
#   -          none of the above found
#
# A name may have several tags. Example: printf is a bash builtin *and*
# /usr/bin/printf, so help is the shell one and man/info are the utility.
#
# The builtin named ":" is the POSIX null command (help :). It is not a keyword.

set -o pipefail
export LC_ALL=C

cleanup() {
  local code=${1:-0}
  trap - INT PIPE TERM
  exit "$code"
}

trap 'cleanup 130' INT
trap 'cleanup 0' PIPE
trap 'cleanup 143' TERM

# Reject info's fallback, which is the top-level dir index.
info_page() {
  local loc
  loc=$(info -w -- "$1" 2>/dev/null) || return 1
  [[ -n $loc ]] || return 1
  [[ $loc == dir || $loc == */dir || $loc == *"/info/dir" ]] && return 1
  return 0
}

man_page() {
  man -w -- "$1" >/dev/null 2>&1
}

# bash `help` only documents builtins / some keywords
help_page() {
  help -- "$1" >/dev/null 2>&1
}

help_sources() {
  local name=$1 kind=$2
  local -a tags=()

  case $kind in
    alias)
      tags+=(alias)
      type -- "$name" >/dev/null 2>&1 && tags+=(type)
      ;;
    function)
      tags+=(declare)
      type -- "$name" >/dev/null 2>&1 && tags+=(type)
      ;;
    builtin)
      tags+=(help)
      ;;
    keyword)
      if help_page "$name"; then
        tags+=(help)
      fi
      tags+=("man bash")
      ;;
    PATH)
      :
      ;;
  esac

  man_page "$name" && tags+=(man)
  info_page "$name" && tags+=(info)

  if ((${#tags[@]} == 0)); then
    printf '%s\n' "-"
  else
    local IFS=,
    printf '%s\n' "${tags[*]}"
  fi
}

print_row() {
  printf '%-10s  %-28s  %s\n' "$1" "$2" "$3" || cleanup 0
}

section() {
  printf '%s\n' "# === $1 ===" || cleanup 0
}

print_row "SECTION" "NAME" "HELP"
print_row "----------" "----------------------------" "------------------------------"

section aliases
while IFS= read -r line; do
  [[ $line == alias\ *=* ]] || continue
  name=${line#alias }
  name=${name%%=*}
  print_row "alias" "$name" "$(help_sources "$name" alias)"
done < <(alias -p 2>/dev/null | sort)

section functions
while IFS= read -r line; do
  name=${line##* }
  [[ -n $name ]] || continue
  print_row "function" "$name" "$(help_sources "$name" function)"
done < <(declare -F | sort)

section builtins
while IFS= read -r name; do
  [[ -n $name ]] || continue
  print_row "builtin" "$name" "$(help_sources "$name" builtin)"
done < <(compgen -b | sort)

section keywords
while IFS= read -r name; do
  [[ -n $name ]] || continue
  print_row "keyword" "$name" "$(help_sources "$name" keyword)"
done < <(compgen -k | sort)

section PATH
while IFS= read -r name; do
  [[ -n $name ]] || continue
  print_row "PATH" "$name" "$(help_sources "$name" PATH)"
done < <(
  find ${PATH//:/ } -maxdepth 1 \( -type f -o -type l \) -executable -printf '%f\n' 2>/dev/null \
    | sort -u
)

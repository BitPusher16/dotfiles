for i in {0..255}; do
    printf '\x1b[38;5;%dmcolour%3d\x1b[0m ' $i $i
    (( i % 8 == 7 )) && printf '\n'
done

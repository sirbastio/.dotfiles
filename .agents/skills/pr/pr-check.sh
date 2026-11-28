#!/bin/sh
# Check a pull request description before it is posted.
# Fails when it doesn't open with what is left for the reader, or reads too long.
# Collapsed <details> blocks, images and HTML comments are not counted.
# Usage: pr-check.sh <description file> [word limit, default 250]
set -eu

file=$1
limit=${2:-250}
failed=0

first=$(grep -v '^[[:space:]]*$' "$file" | head -n 1)
case $first in
  '**Left for you: '*)
    grep -q '^- \[[ xX]\] ' "$file" || {
      echo "FAIL: \"Left for you\" needs a \"- [ ]\" task for each thing left."
      failed=1
    }
    ;;
  '**Nothing left for you.**'*) ;;
  *)
    echo "FAIL: the first line must be \"**Left for you: <n> checks.**\" or \"**Nothing left for you.**\""
    failed=1
    ;;
esac

words=$(
  awk '
    /<details/ { hidden = 1 }
    !hidden { print }
    /<\/details>/ { hidden = 0 }
  ' "$file" |
    sed -E 's/<!--[^>]*-->//g; s/<img[^>]*>//g; s/!\[[^]]*\]\([^)]*\)//g; s/^[[:space:]]*\|?[-: |]+\|?[[:space:]]*$//' |
    wc -w | tr -d ' '
)

if [ "$words" -gt "$limit" ]; then
  echo "FAIL: $words words outside the collapsed block; the limit is $limit."
  failed=1
else
  echo "ok: $words of $limit words"
fi

exit $failed

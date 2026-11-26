#!/bin/sh
# Show a pull request's uploaded images at a fixed width.
# `gh pr create --attach` leaves them as ![alt](url), which GitHub shows at full size.
# Usage: pr-image-width.sh <pr number or url> [width, default 260]
set -eu

pr=$1
width=${2:-260}
body=$(mktemp)
trap 'rm -f "$body"' EXIT

gh pr view "$pr" --json body --jq .body |
  sed -E "s#!\[([^]]*)\]\((https://github\.com/user-attachments/assets/[^)]+)\)#<img src=\"\2\" alt=\"\1\" width=\"$width\">#g" >"$body"

gh pr edit "$pr" --body-file "$body" >/dev/null
echo "$(grep -o "<img src=\"https://github.com/user-attachments/" "$body" | wc -l | tr -d ' ') image(s) at width $width"

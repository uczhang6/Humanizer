#!/bin/sh
# Copies the skills into ~/.claude/skills, replacing older copies of the same skills.
set -e
cd "$(dirname "$0")"
dest="$HOME/.claude/skills"
mkdir -p "$dest"
for skill in skills/*/; do
  name=$(basename "$skill")
  rm -rf "$dest/$name"
  cp -r "$skill" "$dest/$name"
  echo "installed $name"
done

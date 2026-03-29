#!/usr/bin/env bash

container=$(docker ps --format '{{.Names}}' | fzf \
  --height 80% --border \
  --header="Select Container" \
  --preview "docker logs --tail 20 {} 2>&1")

[ -z "$container" ] && exit 0

tmpfile=$(mktemp)
docker logs --timestamps "$container" >"$tmpfile" 2>&1
nvim "+luafile $XDG_CONFIG_HOME/tmux/vi-mode.lua" "$tmpfile"
rm "$tmpfile"

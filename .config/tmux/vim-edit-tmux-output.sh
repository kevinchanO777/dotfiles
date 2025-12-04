#!/usr/bin/env sh
# https://www.reddit.com/r/neovim/comments/1pcum3i/replacing_tmuxs_vim_visual_mode_implementation/
tmpfile=$(mktemp)

tmux capture-pane -peS -32768 >"$tmpfile"

# tmux run-shell cannot recognise ENV $EDITOR
tmux new-window -n:panecapture "nvim '+luafile $XDG_CONFIG_HOME/tmux/vi-mode.lua' '+ normal G $' $tmpfile; rm $tmpfile"

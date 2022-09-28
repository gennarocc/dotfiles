#!/bin/sh
cd ~/.config/gzdoom/wads/
ls -1 **/*.(WAD|pk3|wad) | fzf --border=sharp | xargs gzdoom

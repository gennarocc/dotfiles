#!/bin/sh
cd ~/.config/gzdoom/wads/
ls -h *.WAD | fzf --border=sharp | xargs gzdoom

#!/usr/bin/env bash

PLS_DIR="$HOME/Music/playlists"
TARGET_DIR="$HOME/Music/tmp"
PLS_LIST=('XXX' 'YYY')

for PLS in "${PLS_LIST[@]}"
do
    mkdir -p "$TARGET_DIR/$PLS"
    sed -e 's/.$//;/#/d' "$PLS_DIR/$PLS.m3u" | while read line ; do cp "$line" "$TARGET_DIR/$PLS" ; done
done

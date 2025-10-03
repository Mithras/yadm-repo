#!/usr/bin/env bash

# magick "$(cosmic-screenshot --interactive=false -s /tmp --notify=false)" -crop "$(slurp | sed -re 's/([0-9]+),([0-9]+) ([0-9]+)x([0-9]+)/\3X\4+\1+\2/g')" /tmp/magick.png && swappy -f /tmp/magick.png
grim -g "$(slurp)" - | swappy -f -

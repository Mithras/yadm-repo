#!/usr/bin/env bash
set -euo pipefail

exec alacritty -e \
  ssh \
    -o StrictHostKeyChecking=accept-new \
    -o Compression=yes \
    -t hermes@mithras.app -p 2222 \
    TERM=xterm-256color hermes-ssh

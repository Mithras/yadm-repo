#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.config/opencode"
mkdir -p "$HOME/.local/share/opencode"
mkdir -p "$HOME/.local/state/opencode"

# -v "$HOME/.linkedin-mcp:/home/opencode/.linkedin-mcp" \
docker run -it --rm \
    -v opencode:/home/opencode \
    -v "$HOME/.config/opencode:/home/opencode/.config/opencode" \
    -v "$HOME/.local/share/opencode:/home/opencode/.local/share/opencode" \
    -v "$HOME/.local/state/opencode:/home/opencode/.local/state/opencode" \
    -v "$PWD:/$PWD" \
    --workdir $PWD \
    --network host \
    --env-file "$SCRIPT_DIR/.env" \
    opencode "$@"

#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.config/opencode"
mkdir -p "$HOME/.local/share/opencode"
mkdir -p "$HOME/.local/state/opencode"

# if [ ! -f "$HOME/.config/opencode/skills/open-ralph-wiggum/SKILL.md" ]; then
#     mkdir -p "$HOME/.config/opencode/skills/open-ralph-wiggum"
#     curl -sL "https://raw.githubusercontent.com/Th0rgal/open-ralph-wiggum/refs/heads/master/skills/open-ralph-wiggum/SKILL.md" \
#         -o "$HOME/.config/opencode/skills/open-ralph-wiggum/SKILL.md"
# fi

docker run -it --rm \
    -v opencode:/home/opencode \
    -v "$HOME/.config/opencode:/home/opencode/.config/opencode" \
    -v "$HOME/.local/share/opencode:/home/opencode/.local/share/opencode" \
    -v "$HOME/.local/state/opencode:/home/opencode/.local/state/opencode" \
    -v "$PWD:/$PWD" \
    --workdir $PWD \
    --network host \
    --env-file "$SCRIPT_DIR/.env" \
    --entrypoint /bin/bash \
    opencode

# uvx linkedin-scraper-mcp --transport stdio
# read https://www.linkedin.com/in/sergei-kizilov/

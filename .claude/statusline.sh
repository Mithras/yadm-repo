#!/bin/bash
INPUT=$(cat)

# Helper functions for common extractions
get_cwd() { echo "$INPUT" | jq -r '.cwd'; }
get_model_name() { echo "$INPUT" | jq -r '.model.display_name'; }
get_current_dir() { echo "$INPUT" | jq -r '.workspace.current_dir'; }
get_project_dir() { echo "$INPUT" | jq -r '.workspace.project_dir'; }
get_version() { echo "$INPUT" | jq -r '.version'; }
get_cost() { echo "$INPUT" | jq -r '.cost.total_cost_usd'; }
get_duration() { echo "$INPUT" | jq -r '.cost.total_duration_ms'; }
get_lines_added() { echo "$INPUT" | jq -r '.cost.total_lines_added'; }
get_lines_removed() { echo "$INPUT" | jq -r '.cost.total_lines_removed'; }

# Use the helpers
CWD=$(get_cwd)
echo "📁 ${CWD}"

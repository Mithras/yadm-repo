#!/usr/bin/env bash
set -euo pipefail

# nvidia-smi -i 0 -q -d CLOCK | grep -E "Graphics|Memory"
# nvidia-smi -i 1 -q -d CLOCK | grep -E "Graphics|Memory"

sudo nvidia-smi -i 0 -lgc 3135,3135
sudo nvidia-smi -i 0 -lmc 14001,14001
sudo nvidia-smi -i 1 -lgc 2100,2100
sudo nvidia-smi -i 1 -lmc 9751,9751

# sudo lspci -vvv -s 01:00.0 | grep -iE "LnkCap|LnkSta|ASPM"
# sudo lspci -vvv -s 03:00.0 | grep -iE "LnkCap|LnkSta|ASPM"

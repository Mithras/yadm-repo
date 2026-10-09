#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./setup-mkinitcpio.sh
#   NVIDIA=1 ./setup-mkinitcpio.sh

if [[ ${NVIDIA:-0} == 1 ]]; then
    install -Dm644 /dev/stdin /etc/mkinitcpio.conf.d/uki-nvidia.conf <<'EOF'
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
HOOKS=(base udev autodetect microcode modconf block filesystems keyboard fsck)
EOF
else
    rm -f /etc/mkinitcpio.conf.d/uki-nvidia.conf
fi

install -Dm644 /dev/stdin /usr/share/mkinitcpio/hook.preset.uki <<'EOF'
ALL_kver="/boot/vmlinuz-%PKGBASE%"
PRESETS=('default')
default_uki="/efi/EFI/Linux/arch-%PKGBASE%.efi"
EOF

install -Dm644 /dev/stdin /etc/pacman.d/hooks/80-uki-preset-template.hook <<'EOF'
[Trigger]
Type = Package
Operation = Install
Operation = Upgrade
Target = mkinitcpio

[Action]
Description = Restoring UKI preset template...
When = PostTransaction
Exec = /usr/bin/install -m644 /usr/share/mkinitcpio/hook.preset.uki /usr/share/mkinitcpio/hook.preset
EOF

install -Dm644 /dev/stdin /etc/pacman.d/hooks/zz-sbctl-sign-all.hook <<'EOF'
[Trigger]
Type = Package
Operation = Install
Operation = Upgrade
Target = mkinitcpio

[Trigger]
Type = Path
Operation = Install
Operation = Upgrade
Target = usr/lib/modules/*/vmlinuz

[Action]
Description = Signing UKIs...
When = PostTransaction
Exec = /bin/sh -c 'for u in /efi/EFI/Linux/*.efi; do sbctl sign -s "$u" || true; done'
EOF

rm -f /etc/mkinitcpio.d/*.preset
rm -f /boot/initramfs-*.img

pacman -S --noconfirm mkinitcpio
sbctl verify

# sudo bootctl status

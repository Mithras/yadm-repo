if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  SESSION_TYPE=remote/ssh
else
  case $(ps -o comm= -p "$PPID") in
    sshd|*/sshd) SESSION_TYPE=remote/ssh;;
  esac
fi

if [ "$SESSION_TYPE" != "remote/ssh" ]; then
  fastfetch
fi


eval "$(oh-my-posh init zsh --config ~/.config/zsh/omp.toml)"

# completion
autoload -Uz compinit ; compinit
TRAPUSR1() { rehash }

# third-party
source "$ZDOTDIR/third-party.zsh"

# options
setopt no_beep
setopt append_history hist_find_no_dups hist_ignore_dups hist_reduce_blanks share_history

# styles
zstyle ':completion:*' menu no # select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# variables
HISTFILE="$ZDOTDIR/.histfile"
HISTSIZE=10000
SAVEHIST=10000
export FZF_DEFAULT_OPTS="--exact --ignore-case"
AUTO_NOTIFY_THRESHOLD=10
AUTO_NOTIFY_IGNORE+=("paru" "code")

# aliases
alias ls='lsd --human-readable --group-directories-first --classify'
# alias zsh-bench="$THIRD_PARTY/zsh-bench/zsh-bench"
alias meta-lighthouse='nmcli connection up lighthouse passwd-file lighthouse'
alias meta-vpn='secret-tool lookup setting-name 802-1x ; nmcli connection up FB-VPN --ask'
alias meta-update='sudo dnf upgrade-no-meta'
alias meta-restart-fmenu='systemctl restart --user fmenu'
alias meta-chef-disable='sudo stop_chef_temporarily --solo  edgeos -t 1' # for 1h
alias meta-chef-enable='sudo stop_chef_temporarily --solo edgeos -e'
alias code='code --enable-features=UseOzonePlatform --ozone-platform=wayland'
alias code-fb='code-fb --enable-features=UseOzonePlatform --ozone-platform=wayland'
alias code-fb-insiders='code-fb-insiders --enable-features=UseOzonePlatform --ozone-platform=wayland'
alias openvpn-mithras='sudo openvpn ~/Sync/pc/MithrasOpenVPN.ovpn'
alias ssh-mithras='ssh mithras@192.168.0.2'
alias ssh-ubuntu1='ssh mithras@192.168.0.6'
alias ssh-rpi01='ssh pi@192.168.10.143'
alias ssh-rpi02='ssh pi@192.168.10.208'
alias nmcli-list='nmcli -f in-use,ssid,bssid,freq,signal,bars dev wifi'
alias ncmpcpp-mithras='ncmpcpp -c ~/.config/ncmpcpp/config-mithras'
alias lnav-journalctl='journalctl -f --no-tail -o json -b | lnav'
alias screenshot='~/Documents/scripts/screenshot.sh'
alias yadm-code='yadm enter code --enable-features=UseOzonePlatform --ozone-platform=wayland ~'
alias taiga='env -u DISPLAY WINEPREFIX="$HOME/.wine" wine "C:\\\\users\\$USER\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Taiga\Taiga.lnk"'
alias tmux0='tmux new -As0'

alias g1='gamescope -O HDMI-A-1 -w 3840 -h 2160 -r 120 -f --hdr-enabled --mangoapp -e -- env DXVK_HDR=1 steam -gamepadui'
alias g2='gamescope -O HDMI-A-2 -w 5120 -h 1440 -r 144 -f --hdr-enabled --mangoapp -e -- env DXVK_HDR=1 steam -gamepadui'

alias mpv-hdr1='ENABLE_HDR_WSI=1 mpv --vo=gpu-next --target-colorspace-hint --gpu-api=vulkan --gpu-context=waylandvk'
alias mpv-hdr2='ENABLE_HDR_WSI=1 mpv --vo=drm'

# bindings
source "$ZDOTDIR/bindings.zsh"

#!/usr/bin/env fish

set ROOT (cd (dirname (status --current-filename)); pwd)

mkdir -p ~/.config
mkdir -p ~/.local/bin
mkdir -p ~/Immagini/wallpapers

cp -r $ROOT/config/* ~/.config/
cp -r $ROOT/local-bin/* ~/.local/bin/ 2>/dev/null
cp -r $ROOT/wallpapers/* ~/Immagini/wallpapers/ 2>/dev/null

chmod +x ~/.local/bin/* 2>/dev/null

echo "Config copiate."

if type -q fc-cache
    fc-cache -fv >/dev/null 2>&1
end

if type -q hyprctl
    hyprctl reload >/dev/null 2>&1
end

if pgrep -x waybar >/dev/null
    pkill waybar
    sleep 1
    nohup waybar >/tmp/waybar.log 2>&1 </dev/null &
end

echo "Install completata."

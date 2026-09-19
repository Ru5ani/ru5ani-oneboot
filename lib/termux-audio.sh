#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail
pkg install -y pulseaudio
mkdir -p "$HOME/.config/pulse"
[ -f "$HOME/.config/pulse/default.pa" ] || cp "$PREFIX/etc/pulse/default.pa" "$HOME/.config/pulse/default.pa"
grep -Fq "module-native-protocol-tcp listen=127.0.0.1 auth-anonymous=1" "$HOME/.config/pulse/default.pa" || printf "\nload-module module-native-protocol-tcp listen=127.0.0.1 auth-anonymous=1\n" >> "$HOME/.config/pulse/default.pa"
if [ -f "$HOME/.config/pulse/daemon.conf" ]; then
 grep -Eq "^[[:space:]]*exit-idle-time[[:space:]]*=" "$HOME/.config/pulse/daemon.conf" && sed -i -E "s/^[[:space:]]*exit-idle-time[[:space:]]*=.*/exit-idle-time = -1/" "$HOME/.config/pulse/daemon.conf" || printf "\nexit-idle-time = -1\n" >> "$HOME/.config/pulse/daemon.conf"
else printf "exit-idle-time = -1\n" > "$HOME/.config/pulse/daemon.conf"; fi
pulseaudio -k >/dev/null 2>&1 || true; sleep 1; pulseaudio --start --exit-idle-time=-1; sleep 2
pactl info >/dev/null; pactl list modules short | grep -q module-native-protocol-tcp
echo "[Ru5ani OneBoot] Android audio bridge ready."

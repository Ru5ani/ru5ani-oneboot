#!/usr/bin/env bash
set -euo pipefail
. /etc/os-release
[ "$(uname -m)" = "aarch64" ] || [ "$(uname -m)" = "arm64" ] || { echo "ARM64 required."; exit 1; }
case "$ID" in
ubuntu|debian|kali|linuxmint) export DEBIAN_FRONTEND=noninteractive; apt-get update; apt-get install -y --no-install-recommends curl wget xz-utils pulseaudio-utils pcmanfm libgtk-3-0 libdbus-glib-1-2 libx11-xcb1 libxt6 libxrandr2 libxdamage1 libxcomposite1 libxfixes3 libasound2 libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2;;
arch|manjaro) pacman -Sy --noconfirm --needed curl wget xz pulseaudio gtk3 dbus-glib libx11 libxt libxrandr libxdamage libxcomposite libxfixes alsa-lib nss atk at-spi2-atk cups;;
fedora) dnf install -y curl wget xz pulseaudio-libs gtk3 dbus-glib libX11 libXt libXrandr libXdamage libXcomposite libXfixes alsa-lib nss atk cups;;
alpine) apk add --no-cache curl wget xz pulseaudio-libs gtk+3.0 dbus-glib libx11 libxt libxrandr libxdamage libxcomposite libxfixes alsa-lib nss atk at-spi2-atk cups;;
*) echo "Unsupported Linux: $ID"; exit 1;; esac
mkdir -p /opt/firefox; cd /opt/firefox
V="$(curl -fsSL https://product-details.mozilla.org/1.0/firefox_versions.json | sed -n 's/.*"LATEST_FIREFOX_VERSION":"\([^"]*\)".*/\1/p' | head -n1 || true); [ -n "$V" ] || V=156.0
wget -O firefox.tar.xz "https://ftp.mozilla.org/pub/firefox/releases/$V/linux-aarch64/en-US/firefox-$V.tar.xz"
rm -rf firefox.new firefox; mkdir firefox.new; tar -xf firefox.tar.xz -C firefox.new --strip-components=1; mv firefox.new firefox; rm firefox.tar.xz
mkdir -p "$HOME/.vnc"; touch "$HOME/.vnc/xstartup"; grep -qxF 'export PULSE_SERVER=127.0.0.1' "$HOME/.vnc/xstartup" || printf "\nexport PULSE_SERVER=127.0.0.1\n" >> "$HOME/.vnc/xstartup"
mkdir -p "$HOME/Desktop"; cat > "$HOME/Desktop/Firefox.desktop" <<EOF
[Desktop Entry]
Name=Firefox
Exec=/opt/firefox/firefox/firefox
Icon=/opt/firefox/firefox/browser/chrome/icons/default/default128.png
Terminal=false
Type=Application
Categories=Network;WebBrowser;
EOF
chmod +x "$HOME/Desktop/Firefox.desktop"
echo "[Ru5ani OneBoot] Firefox + audio setup finished."

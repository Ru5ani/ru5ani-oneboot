#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail
BASE="$HOME/.ru5ani-oneboot"; RAW="https://raw.githubusercontent.com/Ru5ani/ru5ani-oneboot/main"
say(){ printf "\n[Ru5ani OneBoot] %s\n" "$*"; }
[ -n "${PREFIX:-}" ] || { echo "Run this in Termux."; exit 1; }
mkdir -p "$BASE"
curl -fsSL "$RAW/lib/termux-audio.sh" -o "$BASE/termux-audio.sh"
bash "$BASE/termux-audio.sh"
mapfile -t L < <(find "$HOME" -maxdepth 3 -type f \( -name 'start-ubuntu*.sh' -o -name 'start-debian*.sh' -o -name 'start-arch*.sh' -o -name 'start-kali*.sh' -o -name 'start-manjaro*.sh' -o -name 'start-fedora*.sh' -o -name 'start-alpine*.sh' -o -name 'start-void*.sh' \) -print 2>/dev/null | sort -u)
[ "${#L[@]}" -gt 0 ] || { echo "No supported Linux launcher found."; exit 1; }
if [ "${#L[@]}" -eq 1 ]; then i=0; else
 echo "Linux environments detected:"
 for n in "${!L[@]}"; do printf "  %d) %s\n" "$((n+1))" "${L[$n]}"; done
 read -rp "Choose the Linux environment: " n; [[ "$n" =~ ^[0-9]+$ ]] && ((n>=1&&n<=${#L[@]})) || exit 1; i=$((n-1))
fi
LAUNCHER="${L[$i]}"; say "Selected: $LAUNCHER"
grep -Eq '(\$@|\$\*)' "$LAUNCHER" || { echo "This launcher does not safely support automatic command forwarding."; exit 2; }
CMD="curl -fsSL '$RAW/lib/linux-setup.sh' -o /tmp/ru5ani-linux-setup.sh && chmod +x /tmp/ru5ani-linux-setup.sh && /tmp/ru5ani-linux-setup.sh"
say "Entering Linux and running setup automatically..."
exec "$LAUNCHER" bash -lc "$CMD"

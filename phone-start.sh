#!/data/data/com.termux/files/usr/bin/bash
# HARZ Network App v0.2 — phone start (Termux, self-contained kit)
# One-time setup (if not already done):  pkg install git nodejs -y
set -e
cd "$(dirname "$0")"
command -v node >/dev/null 2>&1 || { echo "node missing — run:  pkg install nodejs -y"; exit 1; }
[ -f zone/SIGNED-ZONE-V2.json ] || { echo "sealed zone missing in kit"; exit 1; }
HARZ_ZONE="$(pwd)/zone/SIGNED-ZONE-V2.json" HARZ_DOOR_PORT=8080 node harz-door.js &
DOOR_PID=$!
sleep 2
echo "door is up — opening the .harz address bar"
termux-open-url "http://127.0.0.1:8080" 2>/dev/null || echo "open this in your browser:  http://127.0.0.1:8080"
wait $DOOR_PID

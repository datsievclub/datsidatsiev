#!/bin/zsh
cd "$(dirname "$0")"

PORT=4173
while lsof -iTCP:$PORT -sTCP:LISTEN >/dev/null 2>&1; do
  PORT=$((PORT + 1))
done

python3 -m http.server "$PORT" >/tmp/datsiev-club-local-server.log 2>&1 &
SERVER_PID=$!

sleep 1
open "http://127.0.0.1:$PORT/"

echo "Datsiev Club is open at http://127.0.0.1:$PORT/"
echo "Keep this Terminal window open while checking the site."

trap 'kill "$SERVER_PID" >/dev/null 2>&1' INT TERM EXIT
wait "$SERVER_PID"

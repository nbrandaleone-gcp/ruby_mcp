curl -i http://localhost:8080 \
  -H "Accept: application/json" \
  -H "Accept: text/event-stream" \
  --json '{"jsonrpc":"2.0","method":"initialize","id":1,"params":{"protocolVersion":"2026-07-28","capabilities":{},"clientInfo":{"name":"sse-test","version":"1.0"}}}'

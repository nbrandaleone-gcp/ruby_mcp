curl -i http://localhost:8080 \
  -H "Accept: application/json" \
  -H "Accept: text/event-stream" \
  --json '{"jsonrpc":"2.0","method":"tools/list","id":2,"params":{}}'

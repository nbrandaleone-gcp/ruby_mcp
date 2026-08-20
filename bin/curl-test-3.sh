curl -i http://localhost:8080 \
  -H "Accept: application/json" \
  -H "Accept: text/event-stream" \
  --json '{"jsonrpc":"2.0","method":"tools/call","id":3,"params":{"name":"echo_tool","arguments":{"message":"Hello MCP server!"}}}'

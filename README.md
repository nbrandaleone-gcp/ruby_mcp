# README.md

A simple MCP server written in Ruby.
Deployed to Google Cloud Run.

## Creating an App
mkdir my_project && cd my_project 
bundle init 
bundler add sinatra ...

## Starting App
If you have a `config.ru` file in your project root, you can start your
local web server by executing the rackup command in your terminal,
or by starting your rack-compatible web server.  I skip this by having
the application call a Rack handler for the Puma web server directly.

```bash
bundle exec ruby app.rb
```

## Update bundler
bundle update --bundler

## Testing
npx @modelcontextprotocol/inspector --cli http://localhost:8080/mcp --transport http --method tools/list
{
  "tools": [
    {
      "name": "echo_tool",
      "description": "A simple example tool that echoes back its arguments",
      "inputSchema": {
        "type": "object",
        "properties": {
          "message": {
            "type": "string"
          }
        },
        "required": [
          "message"
        ],
        "$schema": "https://json-schema.org/draft/2020-12/schema"
      }
    }
  ]
}

npx @modelcontextprotocol/inspector --cli http://localhost:8080/mcp --transport http --method tools/call --tool-name echo_tool --tool-arg 'message="Hello MCP server!"'
{
  "content": [
    {
      "type": "text",
      "text": "Hello from echo_tool! Message: Hello MCP server!"
    }
  ],
  "isError": false
}

## Appendix:
https://ruby.sdk.modelcontextprotocol.io/
https://github.com/modelcontextprotocol/ruby-sdk
https://nsinenko.com/ruby-mcp-server/


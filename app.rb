# frozen_string_literal: true

require 'bundler/setup'
Bundler.require 
# there is no need to manually require the dependencies
# anymore, as we just called Bundler.require

logger = Logger.new(STDERR)
logger.level = Logger::DEBUG 

class EchoTool < MCP::Tool
  description "A simple example tool that echoes back its arguments"
  input_schema(
    properties: {
      message: { type: "string" },
    },
    required: ["message"]
  )

  class << self
    def call(message:, server_context:)
      MCP::Tool::Response.new([{
        type: "text",
        text: "Hello from echo_tool! Message: #{message}",
      }])
    end
  end
end

server = MCP::Server.new(
  name: "echo",
  tools: [EchoTool],
)

# Build or reference your MCP server transport (e.g., SSE / Streamable HTTP)
mcp_transport = MCP::Server::Transports::StreamableHTTPTransport.new(
  server,
  stateless: true,
  dns_rebinding_protection: false)
# Per MCP 2025-11-25, StreamableHTTPTransport validates the Host and Origin headers 
# by default to prevent DNS rebinding attacks against locally bound servers, 
# rejecting unauthorized values with HTTP 403. Host is allowed for the loopback 
# defaults (127.0.0.1, ::1, localhost), and an Origin header, when present, must be 
# same-origin or explicitly allow-listed. Non-browser clients that send no Origin header 
# are unaffected.

# Build the Rack application with middleware.
# `StreamableHTTPTransport` responds to `call(env)`, so it can be used directly as a Rack app.
rack_app = Rack::Builder.new do
  use(Rack::ShowExceptions)
  use(Rack::CommonLogger, logger)

  map "/ok" do
    run ->(_env) { [200, {"content-type" => "text/plain"}, ["ok"]] }
  end

  map "/debug" do 
    app = Proc.new do |env|
      request = Rack::Request.new(env)
      puts "--- Request Headers ---"
      request.each_header do |key, value|
        puts "#{key}: #{value}"
      end

      [200, { 'Conent-Type' => 'text/plain' }, ['Headers printed to console!\n']]
    end
    run app
  end

  run mcp_transport
end

# Start the server
# Rack::Server.start(app: app, Port: 3000)
Rackup::Handler.get("puma").run(rack_app, Port: 8080, Host: "0.0.0.0")

# Rakfile
# rake -- runs default task
# rake -T -- lists all tasks
#
desc "Default task"
task default: :hello

desc "Print a friendly hello message"
task :hello do
  puts "Hello World! Welcome to Rake"
end

desc "Build container using Google Cloud Build"
task :build do
  sh "gcloud builds submit --region=us-central1 --tag us-central1-docker.pkg.dev/testing-355714/my-docker-repo/ruby_mcp_server:1.0"
end

desc "Deploy container to Cloud Run"
task :deploy do
  sh "gcloud run deploy ruby-mcp-server \
  --image us-central1-docker.pkg.dev/testing-355714/my-docker-repo/ruby_mcp_server:1.0 \
  --region us-central1 \
  --no-invoker-iam-check"
end

desc "Run application locally"
task :run do
  sh "bundle exec ruby app.rb"
end

namespace :test do
  desc "HTTP Get to endpoint"
  task :get do
    sh "curl https://ruby-mcp-server-161156519703.us-central1.run.app/ok"
  end

  desc "Trigger DEBUG. Print out ENV to logging"
  task :debug do 
    sh "curl https://ruby-mcp-server-161156519703.us-central1.run.app/debug"
  end

  desc "List tools available on MCP server"
  task :list do
    sh "npx @modelcontextprotocol/inspector --cli https://ruby-mcp-server-161156519703.us-central1.run.app --transport http --method tools/list"
  end

  desc "Call MCP tool"
  task :call do
    sh "npx @modelcontextprotocol/inspector --cli https://ruby-mcp-server-161156519703.us-central1.run.app --transport http --method tools/call --tool-name echo_tool --tool-arg 'message=\"Hello MCP server!\"'"
  end
end

#############################################

# 3. Tasks with Dependencies (Prerequisites)
# This task will automatically run the :hello task before executing itself.
#desc 'Prepare coffee (requires saying hello first)'
#task coffee: :hello do
#  puts "Brewing a fresh cup of coffee..."
#end
#
# 4. Namespaced Tasks
# Namespaces help organize tasks into logical groups.
#namespace :db do
#  desc 'Simulate creating the database'
#  task :create do
#    puts "Creating database..."
#  end
#
#  desc 'Simulate migrating the database (requires db:create)'
#  task migrate: :create do
#    puts "Migrating database..."
#  end
#end
#
# 5. Tasks that Accept Parameters
# Syntax: task :name, [:param1, :param2]
#desc 'Greet a specific user with their role'
#task :greet, [:name, :role] do |_t, args|
#  # Set default values if arguments are missing
#  args.with_defaults(name: 'Guest', role: 'User')
#  
#  puts "Hello #{args.name}! Your role is: #{args.role}."
#end
#
# 6. Automating Standard Ruby Tests
# Commonly used to run Minitest or RSpec suites.
#require 'rake/testtask'
#
#Rake::TestTask.new(:test) do |t|
#  t.libs << 'lib' << 'test'
#  t.pattern = 'test/**/*_test.rb'
#  t.verbose = true
#end

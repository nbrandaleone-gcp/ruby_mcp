# Thread per process count allows context switching on IO-bound tasks for better CPU utilization.
threads_count = ENV.fetch('RAILS_MAX_THREADS') { 3 }
threads(threads_count, threads_count)

# Processes count, allows better CPU utilization when executing Ruby code.
# Recommended to always run in at least one process so `rack-timeout` RACK_TERM_ON_TIMEOUT=1 can be used
# https://devcenter.heroku.com/articles/h12-request-timeout-in-ruby-mri

#rails_env = ENV.fetch("RAILS_ENV", "development")
rails_env = ENV.fetch("RAILS_ENV", "production")
environment rails_env

case rails_env
when "production"
  workers_count = Integer(ENV.fetch("WEB_CONCURRENCY", 2))
  workers workers_count if workers_count > 1

  preload_app!
when "development"
  worker_timeout 3600
end

# Support IPv6 by binding to host `::` in production instead of `0.0.0.0` and `::1` instead of `127.0.0.1` in development.
#host = ENV.fetch("RAILS_ENV") { "development" } == "production" ? "::" : "::1"
host = "0.0.0.0" # Cloud Run works better by binding to all interfaces

# PORT environment variable is set by Cloud Run in production.
port(ENV.fetch("PORT") { 8080 }, host)

# Allow Puma to be restarted by the `rails restart` command locally.
plugin(:tmp_restart)

# We strongly recommends upgrading to Puma 7+. If you cannot upgrade,
# Please see the Puma 6 and prior configuration section below.
#
# Puma 7+ already supports PUMA_PERSISTENT_TIMEOUT natively. Older Puma versions set:
#
# ```
# persistent_timeout(ENV.fetch("PUMA_PERSISTENT_TIMEOUT") { 95 }.to_i)
# ```
#
# Puma 7+ fixes a keepalive issue that affects long tail response time with Router 2.0.
# Older Puma versions set:
#
# ```
# enable_keep_alives(false) if respond_to?(:enable_keep_alives)
# ```

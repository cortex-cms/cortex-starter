web: bundle exec puma -e $RACK_ENV -b unix:///tmp/web_server.sock --pidfile /tmp/web_server.pid -d
worker: bundle exec sidekiq --config ./config/sidekiq.yml

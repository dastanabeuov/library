# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.17.3'

set :application, 'library'
set :repo_url, 'git@github.com:dastanabeuov/library.git'

# Default deploy_to directory is /var/www/my_app_name
#set :use_sudo, true
set :deploy_to, '/home/deploy/library'
set :deploy_user, 'deploy'

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/master.key'

# Default value for linked_dirs is []
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle .bundle public/system public/uploads storage]

set :keep_releases, 3

set :conditionally_migrate, true

# Set unique identifier for background jobs
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

## Tasks
#before 'deploy:starting', 'config_files:upload'

set :initial, true
before 'deploy:migrate', 'database:create' if fetch(:initial)

after 'deploy:finishing', 'whenever:update_crontab'

after 'deploy:publishing', 'passenger:restart'

after 'deploy:publishing', 'application:reload'

after 'deploy:starting', 'sidekiq:quiet'
after 'deploy:reverted', 'sidekiq:restart'
after 'deploy:published', 'sidekiq:restart'

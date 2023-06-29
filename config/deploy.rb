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
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'storage'

#set :rvm_map_bins, %w{gem rake ruby rails bundle}

after 'deploy:publishing', 'passenger:restart'

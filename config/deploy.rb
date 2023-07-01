# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.17.3'

set :rvm_ruby_version, "ruby-3.1.2"
set :default_env, { rvm_bin_path: "~/.rvm/bin" }

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

after 'deploy:publishing', 'passenger:restart'

set :keep_releases, 3

# # Добавляем этап компиляции Importmap перед перезапуском приложения
# namespace :deploy do
#   task :compile_importmap do
#     on roles(:app) do
#       within release_path do
#         execute :bundle, :exec, "rails", "importmap:compile"
#       end
#     end
#   end

#   # После развертывания, компилируем Importmap и перезапускаем приложение
#   after :publishing, :compile_importmap
#   after :compile_importmap, 'passenger:restart'
# end

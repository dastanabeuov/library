# frozen_string_literal: true

server '192.227.241.211', user: 'deploy', roles: %w[app web db], primary: true

set :stage, :production
set :rails_env, :production

set :branch, 'master'


set :ssh_options, {
  keys: %w[/Users/adk/.ssh/id_rsa.pub],
  forward_agent: true,
  auth_methods: %w[publickey password],
  port: 2222
}

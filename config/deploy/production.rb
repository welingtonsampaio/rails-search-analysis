set :stage, :production

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# role :app, %w{deploy@example.com}
# role :web, %w{deploy@example.com}
# role :db,  %w{deploy@example.com}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server 'zaez.net', user: 'zaez', roles: %w{web app db}, port: 2223

set :deploy_to, '/home/zaez/sistemas/rsa'
set :tmp_dir, "#{fetch(:deploy_to)}/shared/tmp"
set :use_sudo, false
set :ssh_options, {
                    forward_agent: false,
                    auth_methods: %w(publickey)
                }

# RBENV Definitions
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.1.5'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails puma pumactl sidekiq sidekiqctl}
set :rbenv_roles, :all # default value
#set :rbenv_setup, true
#set :rbenv_force_pull, true

# Puma Definitions
set :puma_threads, [2,4]
set :puma_workers, 1
set :puma_init_active_record, true
set :puma_bind, "tcp://0.0.0.0:7788"

## Sidekiq Definitions
# set :sidekiq_default_hooks, true
# set :sidekiq_pid, File.join(shared_path, 'tmp', 'pids', 'sidekiq_staging.pid')
# set :sidekiq_env, fetch(:rack_env, fetch(:rails_env, fetch(:stage)))
# set :sidekiq_log, File.join(shared_path, 'log', 'sidekiq_staging.log')
# set :sidekiq_options, ->{ "-C #{current_path}/config/sidekiq.yml" }
# set :sidekiq_require,nil
# set :sidekiq_tag,nil
# set :sidekiq_timeout, 20
# set :sidekiq_role, :silo_staging
# set :sidekiq_processes, 1
# set :sidekiq_cmd, "#{fetch(:bundle_cmd, "bundle")} exec sidekiq"
# set :sidekiqctl_cmd, "#{fetch(:bundle_cmd, "bundle")} exec sidekiq"

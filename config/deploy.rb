require "bundler/capistrano"
capistrano_config = YAML::load(File.read("config/capistrano.yml"))
server capistrano_config['server'], :web, :app, :db, primary: true
set :server_name, capistrano_config['server_name']
set :application, "attendance_management"
set :repository,  "git@github.com:knishioka/attendance_management.git"
set :scm, :git
set :branch, capistrano_config['branch']
set :user, capistrano_config['user']
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
after "deploy", "deploy:cleanup"

load "config/recipes/base"
load "config/recipes/unicorn"
load "config/recipes/nginx"

namespace :deploy do
  task :setup_config, roles: :app do
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml" unless remote_file_exists?("#{shared_path}/config/database.yml")
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/#{branch}`
      puts "WARNING: HEAD is not the same as origin/#{branch}"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end

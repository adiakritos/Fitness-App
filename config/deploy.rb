require "bundler/capistrano"
require "rvm/capistrano"

# AWS
default_run_options[:pty]   = true
ssh_options[:forward_agent] = true
ssh_options[:auth_methods]  = ["publickey"]
ssh_options[:keys]          = ["#{ENV['HOME']}/.ssh/getjoocy.com"]

# RVM/Capistrano
before 'deploy:setup',  'rvm:install_rvm'
before 'deploy:setup',  'rvm:install_ruby'
set :rvm_ruby_string,   'ruby-2.0.0-p247'
set :rvm_autolibs_flag, 'read-only'
set :bundle_dir,        ''
set :bundle_flags,      '--system --quiet'

# Git
set :application,   'fitness'
set :repository,    'git@github.com:adiakritos/Fitness-App'
set :scm,           :git
set :branch,        'master'
set :deploy_via,    :remote_cache      
set :keep_releases, 7                                 
set :user,          'www'
set :use_sudo,      false   
set :deploy_to,     "/var/www/apps/#{application}"                        

role :web, "getjoocy.com"
role :app, "getjoocy.com"
role :db,  "getjoocy.com", primary: true

# Passenger
after "deploy", "passenger:restart"
namespace :passenger do
  desc "Restart Passenger"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

# Database
namespace :database do

  desc "Seed database"
  task :seed do
    run "cd #{current_path} && bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end

  desc "Drop database"
    task :drop do
      run "cd #{current_path} && bundle exec rake db:drop RAILS_ENV=#{rails_env}"
    end

  desc "Create database"
    task :create do
      run "cd #{current_path} && bundle exec rake db:create RAILS_ENV=#{rails_env}"
  end
    
end

# Post Deploy
after "deploy:restart", "deploy:cleanup"

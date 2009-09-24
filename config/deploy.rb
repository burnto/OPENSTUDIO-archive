# The host where people will access my site
set :application, "openstudio.tacolab.com"
set :user, "openstudio"
set :admin_login, "openstudio"

# repo info
set :repository,  "git@github.com:burnto/OPENSTUDIO-archive.git"
set :scm, "git"
set :branch, "master"

set :deploy_to, "/home/#{admin_login}/#{application}"

# My DreamHost-assigned server
set :domain, "#{application}"
role :app, domain
role :web, domain
role :db,  domain, :primary => true

set :use_sudo, false
# set :checkout, "export"
set :scm_verbose, true 
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache

# additional settings
default_run_options[:pty] = true  # Forgo errors when deploying from windows
#ssh_options[:keys] = %w(/Path/To/id_rsa)            # If you are using ssh_keys
set :chmod755, "app config db lib public vendor script script/* public/disp*"

#############################################################
#	Passenger
#############################################################

namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after :deploy, "passenger:restart"
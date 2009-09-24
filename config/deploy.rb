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
set :git_enable_submodules,1


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

namespace :deploy do
 
  task :symlink_shared do
    run "ln -s #{shared_path}/db #{latest_release}/db/shared"
    run "ln -s #{shared_path}/system #{release_path}/public/system"
  end

  desc "Restart Application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end

end

after 'deploy:finalize_update', 'deploy:symlink_shared'
after :deploy, "passenger:restart"

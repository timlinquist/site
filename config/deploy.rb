require 'new_relic/recipes'

fail_message = "\nInvalid deploy_env specified\n\tUsage: cap {command} -S deploy_env={environment}\nReview config\deploy.rb to see what environments are\ncurrently defined.\n\n"

begin; deploy_env; rescue NameError; set :deploy_env, 'integration' end

set :user, 'deploy'
set :domain, 'confreaks.net'
set :use_sudo, false
set :deploy_via, :copy

# version control config

ssh_options[:forward_agent] = true

set :scm, 'git'
set :scm_username, 'deploy'
set :scm_password, 'confreaks-deploy'
set :repository, "git@github.com:confreaks/site"
set :branch, 'master'

set :home_dir, "/home/#{user}"

case deploy_env
when 'linode'
  set :application, "#{domain}"
  role :web, '74.82.5.122'
  role :app, '74.82.5.122'
when 'integration'
  set :application, "beta.#{domain}"
  role :web, domain
  role :app, domain
when 'production'
  set :application, "www.#{domain}"
  role :web, domain
  role :app, domain
when 'bluebox'
  set :application, "www.#{domain}"
  role :web, "confreaks.com"
  role :app, "confreaks.com"
else
  puts fail_message
  exit
end

set :applicationdir, "#{home_dir}/#{application}"
set :deploy_to, applicationdir

# New Relic deployment notification
after 'deploy:update', "newrelic:notice_deployment"
after 'deploy:update', "deploy:isolate_symlink"

after "deploy", "deploy:cleanup"

namespace :deploy do
  task :start do
  end
  task :stop do
  end
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "touch #{File.join(current_path, 'tmp','restart.txt')}"
  end
  task :isolate_symlink do
    run <<-CMD
      ln -s #{shared_path}/isolate #{latest_release}/tmp/isolate
    CMD
  end
end

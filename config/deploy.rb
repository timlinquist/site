fail_message = "\nInvalid deploy_env specified\n\tUsage: cap {command} -S deploy_env={environment}\nReview config\deploy.rb to see what environments are\ncurrently defined.\n\n"

begin; deploy_env; rescue NameError; set :deploy_env, 'integration' end

set :user, 'confreakadmin'
set :domain, 'confreaks.net'
set :use_sudo, false

# version control config

ssh_options[:forward_agent] = true

set :scm, 'git'
set :scm_username, 'deploy'
set :scm_password, 'confreaks-deploy'
set :repository, "git@github.com:confreaks/site"
set :branch, 'master'

set :application, "confreaks.net"

set :home_dir, "/home/#{user}"

case deploy_env
when 'integration'
  set :application, "beta.#{domain}"
  role :web, domain
  role :app, domain
when 'production'
  set :application, "www.#{domain}"
  role :web, domain
  role :app, domain
else
  puts fail_message
  exit
end

set :applicationdir, "#{home_dir}/#{application}"
set :deploy_to, applicationdir

# New Relic deployment notification
after 'deploy:update', "newrelic:notice_deployment"

after "deploy", "deploy:cleanup", "deploy:isolate"

namespace :deploy do
  task :start do
  end
  task :stop do
  end
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "touch #{File.join(current_path, 'tmp','restart.txt')}"
  end
  task :isolate do
    run "cd #{deploy_to}/current && /usr/bin/env rake environment RAILS_ENV=production"
    run "cd #{deploy_to}/current && /usr/bin/env rake environment RAILS_ENV=production"
  end
end

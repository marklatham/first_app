# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, "infocoop"
set :repo_url, "git@github.com:marklatham/infocoop.git"
set :branch, ENV["REVISION"] || ENV["BRANCH_NAME"] || "master"

set :linked_files, %w{config/database.yml config/secrets.yml config/puma.rb .env}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

set :keep_releases, 5
set :chruby_ruby, "2.1.2"

set :ssh_options, {
  forward_agent: true,
}

namespace :deploy do

  desc "Restart application"
  task :restart do
    invoke "puma:restart"
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

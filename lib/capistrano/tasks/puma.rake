namespace :puma do

  desc "Restart puma instance for this application"
  task :restart do
    on roles(:app) do
      within release_path do
        execute 'sudo service puma restart'
      end
    end
  end

end

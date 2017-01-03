role :app, %w{deploy@sofcoop.org}
role :web, %w{deploy@sofcoop.org}
role :db,  %w{deploy@sofcoop.org}

server "sofcoop.org", user: "deploy", roles: %w{web app}

set :branch, 'master'
set :deploy_to, '/var/www/www.infocoop'

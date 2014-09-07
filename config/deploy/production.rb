role :app, %w{deploy@votermedia.info}
role :web, %w{deploy@votermedia.info}
role :db,  %w{deploy@votermedia.info}

server "votermedia.info", user: "deploy", roles: %w{web app}

set :branch, 'master'
set :deploy_to, '/var/www/www.infocoop'

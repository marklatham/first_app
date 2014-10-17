role :app, %w{deploy@vaninfocoop.ca}
role :web, %w{deploy@vaninfocoop.ca}
role :db,  %w{deploy@vaninfocoop.ca}

server "vaninfocoop.ca", user: "deploy", roles: %w{web app}

set :branch, 'master'
set :deploy_to, '/var/www/www.infocoop'

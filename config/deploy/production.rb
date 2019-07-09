set :stage, :production

server '167.99.232.239', roles: %w[app web db], primary: true, user: 'deployer'
set :rails_env, 'production'

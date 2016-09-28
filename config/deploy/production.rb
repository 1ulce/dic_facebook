server '52.198.85.142', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/ch0chip/.ssh/app_aws_key'
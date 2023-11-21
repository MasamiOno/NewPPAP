#set :app_eip, '54.250.124.86'

set :ssh_options, {
    keys: [File.expand_path('~/.ssh/EbitenpuraAppKey.pem')],
    forward_agent: true,
    auth_methods: %w(publickey)
}

role :app, 'ec2-user@54.250.124.86'
role :web, 'ec2-user@54.250.124.86'
role :db,  'ec2-user@54.250.124.86'


#set :default_env, {
#rbenv_root: "/opt/rbenv"
#}


#server '54.250.124.86', user: 'admin', roles: %w{web app db}

#set :ssh_options, {
#keys: [File.expand_path('~/.ssh/new_rsa')],
#forward_agent: true,
#auth_methods: %w(publickey)
#}


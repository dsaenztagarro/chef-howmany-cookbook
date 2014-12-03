node.default['postgresql']['version'] = '9.3.4'
node.default['postgresql']['password']['postgres'] = 'postgres'
include_recipe 'postgresql::server'
include_recipe 'postgresql::client'

include_recipe 'database'
include_recipe 'database::postgresql'

postgresql_connection_info = {
  :host     => '127.0.0.1',
  :port     => node['postgresql']['config']['port'],
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

# create a mysql user but grant no privileges
postgresql_database_user 'development' do
  connection postgresql_connection_info
  password   'development'
  action     :create
end

# Create database
[:development, :test].each do |environment|
  postgresql_database "#{node['project_name']}_#{environment}" do
    connection postgresql_connection_info
    owner 'development'
    action :create
  end
end

# Grant all privileges
[:development, :test].each do |environment|
  postgresql_database_user 'development' do
    connection    postgresql_connection_info
    database_name "#{node['project_name']}_#{environment}"
    privileges    ['ALL PRIVILEGES']
    action        :grant
  end
end

postgresql_database 'postgres' do
  connection    postgresql_connection_info
  sql 'ALTER ROLE development CREATEDB;'
  action :query
end

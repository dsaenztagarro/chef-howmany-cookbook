#
# Cookbook Name:: howmany
# Recipe:: default
#
# Copyright (C) 2014 David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

# howmany-backend config

execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end

node.default['rvm']['default_ruby'] = 'ruby-2.1.2'
node.default['rvm']['rubies'] = ['ruby-2.1.2']
node.default['rvm']['vagrant']['system_chef_solo'] = '/opt/chef/bin/chef-solo'

include_recipe 'rvm::vagrant'
include_recipe 'rvm::system'

# howmany-frontend config

node.default['nodejs']['version'] = '0.10.33'

include_recipe 'nodejs'
include_recipe 'nodejs::npm'

%w(bower ember-cli phantomjs).each do |node_module|
  nodejs_npm node_module do
    options ['--global']
  end
end

# paperclip dependencies
# %w(imagemagick php5-imagick libmagickwand-dev).each do |package_name|
#   package package_name
# end


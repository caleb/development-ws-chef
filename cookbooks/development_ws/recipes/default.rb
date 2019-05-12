#
# Cookbook Name:: development_ws
# Recipe:: default
#
# Copyright 2019, Caleb Land
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'development_ws::apt_repositories'

# Set the user password
include_recipe 'development_ws::user'

# Create directories
include_recipe 'development_ws::directories'

# Enable userns for the brave browser
include_recipe 'development_ws::userns'

# Configure networking
include_recipe 'development_ws::networking'
include_recipe 'development_ws::ssh_known_hosts'

# Install Packages
include_recipe 'development_ws::packages'

# Install dotfiles and configure the shell
include_recipe 'development_ws::dotfiles'
include_recipe 'development_ws::ssh'

# Clone projects I use
include_recipe 'development_ws::projects'

# Configure settings of the desktop
include_recipe 'development_ws::settings'

# Add our user to some groups
include_recipe 'development_ws::groups'

# Configure samba
include_recipe 'development_ws::samba'

# Configure docker
include_recipe 'development_ws::docker'
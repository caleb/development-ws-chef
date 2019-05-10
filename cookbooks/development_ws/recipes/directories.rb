username = node[:username]
group = username
home_directory = "/home/#{username}"
projects_directory = "#{home_directory}/Projects"

#
# Project Directory
#
directory(projects_directory) do
  action :create
  owner username
  group username
  mode '0775'
end

bash("Set ACL for project directory #{projects_directory}") do
  code <<-BASH
    setfacl -m u:#{username}:rwX -m default:u:#{username}:rwX -m g:#{group}:rwX -m default:g:#{group}:rwX -m mask::rwX -m default:mask::rwX #{projects_directory}     
  BASH
end

#
# ~/.local
#
directory("#{home_directory}/.local") do
  action :create
  owner username
  group username
  mode '0700'
end

directory("#{home_directory}/.local/bin") do
  action :create
  owner username
  group username
  mode '0700'
end
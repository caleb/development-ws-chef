username = node[:username]
group = username
home_directory = "/home/#{username}"
ssh_directory = "/home/#{username}/.ssh"
projects_directory = "#{home_directory}/Projects"
downloads_directory = "#{home_directory}/Downloads"

directory "#{ssh_directory}" do
  owner username
  group group
  mode '0700'
end

#
# Download Directory (this is created by gnome automatically on first login,
# but we want to make sure it exists because we put stuff in there)
#
directory(downloads_directory) do
  action :create
  owner username
  group username
  mode '0755'
end

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
    setfacl -m u:#{username}:rwX \\
            -m default:u:#{username}:rwX \\
            -m g:#{group}:rwX \\
            -m default:g:#{group}:rwX \\
            -m u:www-data:rwX \\
            -m default:u:www-data:rwX \\
            -m g:www-data:rwX \\
            -m default:g:www-data:rwX \\
            -m mask::rwX \\
            -m default:mask::rwX \\
            #{projects_directory}     
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
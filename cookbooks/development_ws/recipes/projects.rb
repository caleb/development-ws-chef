username = node[:username]
group = username
home_directory = "/home/#{username}"
projects_directory = "#{home_directory}/Projects"

git "#{projects_directory}/gruvbox-idea" do
  repository 'git@github.com:caleb/gruvbox-idea.git'
  action :checkout
  checkout_branch 'master'
  enable_checkout false
end
bash "chown #{projects_directory}/gruvbox-idea to #{username}:#{group}" do
  code <<-BASH
    chown -R #{username}:#{group} #{projects_directory}/gruvbox-idea
  BASH
end

git "#{projects_directory}/delivery" do
  repository 'git@github.com:caleb/delivery.git'
  action :checkout
  checkout_branch 'master'
  enable_checkout false
end
bash "chown #{projects_directory}/delivery to #{username}:#{group}" do
  code <<-BASH
    chown -R #{username}:#{group} #{projects_directory}/delivery
  BASH
end

git "#{projects_directory}/strongman" do
  repository 'git@github.com:caleb/strongman.git'
  action :checkout
  checkout_branch 'master'
  enable_checkout false
end
bash "chown #{projects_directory}/strongman to #{username}:#{group}" do
  code <<-BASH
    chown -R #{username}:#{group} #{projects_directory}/strongman
  BASH
end

directory "#{projects_directory}/chef" do
  owner username
  group username
  mode '0755'
end

git "#{projects_directory}/chef/mojo_tools-chef" do
  repository 'git@bitbucket.org:caleb_land/mojo_tools-chef.git'
  action :checkout
  checkout_branch 'master'
  enable_checkout false
end
bash "chown #{projects_directory}/mojo_tools to #{username}:#{group}" do
  code <<-BASH
    chown -R #{username}:#{group} #{projects_directory}/mojo_tools
  BASH
end

git "#{projects_directory}/mojo_tools" do
  repository 'git@bitbucket.org:caleb_land/mojo_tools.git'
  action :checkout
  checkout_branch 'master'
  enable_checkout false
end
bash "chown #{projects_directory}/chef/mojo_tools-chef to #{username}:#{group}" do
  code <<-BASH
    chown -R #{username}:#{group} #{projects_directory}/chef/mojo_tools-chef
  BASH
end

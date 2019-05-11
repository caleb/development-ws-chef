username = node[:username]
group = username
home_directory = "/home/#{username}"
projects_directory = "#{home_directory}/Projects"
dotfiles_directory = "#{projects_directory}/dotfiles"

# Clone the dotfiles
git dotfiles_directory do
  repository 'git@github.com:caleb/dotfiles.git'
  action :checkout
end
bash "chown #{dotfiles_directory} to #{username}:#{group}" do
  code <<-BASH
    chown -R #{username}:#{group} #{dotfiles_directory}
  BASH
end


cookbook_file "#{home_directory}/.zshenv.local" do
  source 'dotfiles/zshenv.local'
  owner username
  group username
end
template "#{home_directory}/.rcrc" do
  source 'rcrc.erb'
  owner username
  group username
end
cookbook_file "#{dotfiles_directory}/settings.yml" do
  source 'dotfiles/settings.yml'
  owner username
  group username
end
cookbook_file "#{dotfiles_directory}/gitconfig.local" do
  source 'dotfiles/gitconfig.local'
  owner username
  group username
end

bash 'run rcup' do
  code <<-BASH
    sudo -u #{username} rcup
  BASH
end
username = node[:username]
group = node[:username]

ruby_version = node[:ruby_version] || "2.6.3"
nodejs_version = node[:nodejs_version] || "10.15.3"

git "/home/#{username}/.asdf" do
  action :checkout
  repository 'https://github.com/asdf-vm/asdf.git'
  revision node[:asdf_version]
  user username
  group group
end

bash 'install asdf plugins' do
  returns [0, 2]
  code <<-BASH
    sudo -u #{username} bash -c "
      . /home/#{username}/.asdf/asdf.sh;
      asdf plugin-add ruby;
      asdf plugin-add nodejs;
      asdf plugin-add erlang;
      asdf plugin-add elixir;
      asdf plugin-add rust;
      asdf plugin-add clojure;
    "
  BASH
end

bash "install asdf ruby version #{ruby_version}" do
  cwd "/home/#{username}"
  code <<-BASH
    sudo -u #{username} bash -c "
      . /home/#{username}/.asdf/asdf.sh;
      asdf install ruby #{ruby_version};
      asdf global ruby #{ruby_version};
    "
  BASH

  creates "/home/#{username}/.asdf/installs/ruby/#{ruby_version}"
end

bash "install asdf nodejs version #{nodejs_version}" do
  cwd "/home/#{username}"
  code <<-BASH
    sudo -u #{username} bash -c "
      . /home/#{username}/.asdf/asdf.sh;
      bash /home/#{username}/.asdf/plugins/nodejs/bin/import-release-team-keyring;
      asdf install nodejs #{nodejs_version};
      asdf global nodejs #{nodejs_version};
    "
  BASH

  creates "/home/#{username}/.asdf/installs/nodejs/#{nodejs_version}"
end

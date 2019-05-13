#
# VMWare Tools
#
package 'open-vm-tools-desktop'

#
# Development packages
#
package 'openjdk-11-jdk'

package 'autoconf'
package 'm4'
package 'bison'
package 'build-essential'
package 'libssl-dev'
package 'libyaml-dev'
package 'libreadline-dev'
package 'zlib1g-dev'
package 'libncurses5-dev'
package 'libffi-dev'
package 'libgdbm6'
package 'libgdbm-dev'
package 'libwxgtk3.0-dev'
package 'libgl1-mesa-dev'
package 'libglu1-mesa-dev'
package 'libpng-dev'
package 'libssh-dev'
package 'unixodbc-dev'
package 'xsltproc' 
package 'fop'

package 'docker-ce'
package 'docker-ce-cli'
package 'containerd.io'
package 'docker-compose'

package 'ruby'
package 'leiningen'

#
# Utilities
#
package 'hub'
package 'ripgrep'
package 'rlwrap'
package 'rcm'
package 'editorconfig'

#
# Applications
#
package 'vim'

package 'syncthing-gtk'
package 'zeal'
package 'brave-browser'
package 'brave-keyring'
package 'code'
package 'atom'

#
# Jetbrains Toolbox
#
remote_file "/home/#{node[:username]}/Downloads/jetbrains-toolbox-1.14.5179.tar.gz" do
  source 'https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.14.5179.tar.gz'
  owner node[:username]
  group node[:username]
  not_if { ::File.exist?("/home/#{node[:username]}/.local/share/JetBrains") }
end

#
# Install clojure
#
remote_file "/home/#{node[:username]}/Downloads/linux-install-1.10.0.442.sh" do
  source 'https://download.clojure.org/install/linux-install-1.10.0.442.sh'
  owner node[:username]
  group node[:username]
  mode '0755'
  not_if { ::File.exist?("/usr/local/bin/clojure") }
end

bash 'install clojure' do
  code <<-BASH
    cd /home/#{node[:username]}/Downloads
    bash linux-install-1.10.0.442.sh
  BASH
  not_if { ::File.exist?("/usr/local/bin/clojure") }
end

remote_file '/usr/local/bin/boot' do
  source 'https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh'
  owner 'root'
  group 'root'
  mode '0755'
end

#
# Chef Workstation
#
remote_file "/home/#{node[:username]}/Downloads/chef-workstation_0.2.53-1_amd64.deb" do
  source 'https://packages.chef.io/files/stable/chef-workstation/0.2.53/ubuntu/18.04/chef-workstation_0.2.53-1_amd64.deb'
  owner node[:username]
  group node[:username]
  not_if { ::File.exist?("/usr/bin/chef") }
end

dpkg_package 'chef-workstation' do
  source "/home/#{node[:username]}/Downloads/chef-workstation_0.2.53-1_amd64.deb"
end

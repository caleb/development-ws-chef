#
# VMWare Tools
#
package 'open-vm-tools-desktop' if (node[:features] || {})[:open_vm_tools] != false

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
package 'php-cli'

package 'docker-ce'
package 'docker-ce-cli'
package 'containerd.io'
package 'docker-compose'

package 'ruby'
package 'leiningen'

package 'dpkg-dev'

#
# Utilities
#
package 'hub'
package 'ripgrep'
package 'rlwrap'
package 'rcm'
package 'editorconfig'
package 'pass'
package 'pass-extension-otp'

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
remote_file "/home/#{node[:username]}/Downloads/linux-install-1.10.1.466.sh" do
  source 'https://download.clojure.org/install/linux-install-1.10.1.466.sh'
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
# Fetch packages to put in our local apt repository
#

remote_file('/srv/apt/chef-workstation_0.7.4-1_amd64.deb') { source 'https://packages.chef.io/files/stable/chef-workstation/0.7.4/ubuntu/18.04/chef-workstation_0.7.4-1_amd64.deb' }
remote_file('/srv/apt/dissenter-browser-v0.66.99-amd64.deb') { source 'https://dissenter.com/dist/browser/0.66.99/dissenter-browser-v0.66.99-amd64.deb' }

autokey_version = '0.95.7-0'
autokey_tag = 'v0.95.7'
%w{autokey-common autokey-gtk}.each do |autokey_package|
  package_filename = "#{autokey_package}_#{autokey_version}_all.deb"
  filename = "/srv/apt/#{package_filename}"
  remote_file(filename) { source "https://github.com/autokey/autokey/releases/download/#{autokey_tag}/#{package_filename}" }
end

bash 'update local package repository' do
  action :run
  code <<-BASH
    cd /srv/apt
    rm -f Packages
    dpkg-scanpackages -m . > Packages
    apt update
  BASH
end

#
# Install our local packages
#
package('chef-workstation')
package('dissenter-browser')
package('autokey-common') { version autokey_version }
package('autokey-gtk') { version autokey_version }

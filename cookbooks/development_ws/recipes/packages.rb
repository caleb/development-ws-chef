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
package 'clojure'

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
end
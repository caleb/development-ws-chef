#
# These packages are required to install over HTTPs
#
package 'apt-transport-https'
package 'ca-certificates'
package 'curl'
package 'gnupg2'
package 'software-properties-common'

distribution = node[:distribution] || `/usr/bin/lsb_release -cs`.strip

apt_repository 'non-free' do
  uri 'http://zfs.local/debian'
  distribution distribution
  deb_src true
  components ['non-free']
end

apt_repository 'thoughtbot' do
  uri 'https://apt.thoughtbot.com/debian/'
  key "https://apt.thoughtbot.com/thoughtbot.gpg.key"
  distribution 'stable'
  components ['main']
end

apt_repository 'vscode' do
  arch 'amd64'
  uri 'http://packages.microsoft.com/repos/vscode'
  key 'https://packages.microsoft.com/keys/microsoft.asc'
  distribution 'stable'
  components ['main']
end

apt_repository 'brave' do
  arch 'amd64'
  uri 'https://brave-browser-apt-release.s3.brave.com/'
  key 'https://brave-browser-apt-release.s3.brave.com/brave-core.asc'
  distribution distribution
  components ['main']
end

apt_repository 'atom' do
  arch 'amd64'
  uri 'https://packagecloud.io/AtomEditor/atom/any/'
  key 'https://packagecloud.io/AtomEditor/atom/gpgkey'
  distribution 'any'
  components ['main']
end

apt_repository 'docker' do
  arch 'amd64'
  uri 'https://download.docker.com/linux/debian/'
  key 'https://download.docker.com/linux/debian/gpg'
  components ['stable']
end
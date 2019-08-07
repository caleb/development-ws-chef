distribution = node[:distribution] || `/usr/bin/lsb_release -cs`.strip
url = node[:apt_repository_url] || 'https://deb.debian.org/debian/'

use_proxy = !! node[:features][:apt_proxy]
proxy = node[:features][:apt_proxy]

proxyify = -> (url) do
  if use_proxy
    url.gsub(%r{https://}, 'http://HTTPS///')
  else
    url
  end
end

file '/etc/apt/apt.conf.d/00proxy' do
  action use_proxy ? :create : :destroy
  owner 'root'
  group 'root'
  mode '0644'
  content %Q{Acquire::http { Proxy "#{proxy}"; };}
end

template '/etc/apt/sources.list' do
  source 'sources.list.erb'
  owner 'root'
  group 'root'
  mode '0644'

  variables url: url, distribution: distribution
end

apt_update 'update' do
  action :nothing
  subscribes :update, 'template_file[/etc/apt/sources.list]', :immediately
end

#
# These packages are required to install over HTTPs
#
package 'apt-transport-https'
package 'ca-certificates'
package 'curl'
package 'gnupg'
package 'software-properties-common'

apt_repository 'non-free' do
  uri url
  distribution distribution
  deb_src true
  components ['non-free']
end

apt_repository 'thoughtbot' do
  uri proxyify.('https://apt.thoughtbot.com/debian/')
  key "https://apt.thoughtbot.com/thoughtbot.gpg.key"
  distribution 'stable'
  components ['main']
end

apt_repository 'vscode' do
  arch 'amd64'
  uri proxyify.('https://packages.microsoft.com/repos/vscode')
  key 'https://packages.microsoft.com/keys/microsoft.asc'
  distribution 'stable'
  components ['main']
end

apt_repository 'brave' do
  arch 'amd64'
  uri proxyify.('https://brave-browser-apt-release.s3.brave.com/')
  key 'https://brave-browser-apt-release.s3.brave.com/brave-core.asc'
  distribution distribution
  components ['main']
end

apt_repository 'atom' do
  arch 'amd64'
  uri proxyify.('https://packagecloud.io/AtomEditor/atom/any/')
  key 'https://packagecloud.io/AtomEditor/atom/gpgkey'
  distribution 'any'
  components ['main']
end

apt_repository 'docker' do
  arch 'amd64'
  uri proxyify.('https://download.docker.com/linux/debian/')
  key 'https://download.docker.com/linux/debian/gpg'
  components ['stable']
end

directory('/srv/apt') { owner node[:username]; group node[:username] }

apt_repository 'local' do
  uri 'file:/srv/apt'
  trusted true
  distribution './'
end

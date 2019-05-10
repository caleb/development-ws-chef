package 'avahi-daemon'
package 'avahi-discover' 
package 'libnss-mdns'

template '/etc/avahi/avahi-daemon.conf' do
  source 'avahi-daemon.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
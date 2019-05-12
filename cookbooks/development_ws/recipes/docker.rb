#
# Start docker on a TCP port
#
directory '/etc/systemd/system/docker.service.d' do
  owner 'root'
  group 'root'
  mode '0755'
end

cookbook_file '/etc/systemd/system/docker.service.d/override.conf' do
  source 'docker-unit-override.conf'
  owner 'root'
  group 'root'
  mode '0644'
end

bash 'reload systemd definitions when docker override changes' do
  action :nothing
  code <<-BASH
    systemctl daemon-reload
  BASH
  subscribes :run, 'cookbook_file[/etc/systemd/system/docker.service.d/override.conf]', :immediately
end

service 'docker' do
  action :nothing
  subscribes :restart, 'cookbook_file[/etc/systemd/system/docker.service.d/override.conf]', :immediately
end
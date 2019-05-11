known_host = -> (site) do
  ssh_known_hosts_entry(site) {
    owner node[:username]
    group node[:username]
    mode '0544'
    file_location "/home/#{node[:username]}/.ssh/known_hosts"
  }
  ssh_known_hosts_entry(site) {
    owner 'root'
    group 'root'
    mode '0544'
    file_location "/root/.ssh/known_hosts"
  }
end

known_host.('github.com')
known_host.('bitbucket.org')
known_host.('tools.mojoyourfranchise.com')

ssh_known_hosts_entry("flush /home/#{node[:username]}/.ssh/known_hosts") do
  action :flush
  file_location "/home/#{node[:username]}/.ssh/known_hosts"
end
ssh_known_hosts_entry("flush /root/.ssh/known_hosts") do
  action :flush
  file_location "/root/.ssh/known_hosts"
end
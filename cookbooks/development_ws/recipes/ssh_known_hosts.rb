ssh_known_hosts_entry("github.com") { owner node[:username] }
ssh_known_hosts_entry("bitbucket.org") { owner node[:username] }

ssh_known_hosts_entry("tools.mojoyourfranchise.com") { owner node[:username] }
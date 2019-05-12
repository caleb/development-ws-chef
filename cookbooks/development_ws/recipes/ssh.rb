username = node[:username]
group = username
home_directory = "/home/#{username}"
ssh_directory = "#{home_directory}/.ssh"

cookbook_file "#{ssh_directory}/id_rsa.pub" do
  owner username
  group group
  mode '0644'
end

bash "authorize the id_rsa.pub key for the user" do
  code <<-BASH
    touch #{ssh_directory}/authorized_keys
    cat #{ssh_directory}/id_rsa.pub >> #{ssh_directory}/authorized_keys
    cat #{ssh_directory}/authorized_keys | sort | uniq > #{ssh_directory}/authorized_keys.new
    mv -f #{ssh_directory}/authorized_keys.new #{ssh_directory}/authorized_keys
    chown #{username}:#{group} #{ssh_directory}/authorized_keys
  BASH
end

private_key = node[:secrets][:id_rsa]

if private_key && ! private_key.strip.empty?
  file "#{ssh_directory}/id_rsa" do
    content private_key
    mode '0400'
    owner username
    group group
  end
end
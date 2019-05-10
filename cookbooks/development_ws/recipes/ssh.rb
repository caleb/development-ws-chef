username = node[:username]
group = username
home_directory = "/home/#{username}"
ssh_directory = "#{home_directory}/.ssh"

directory "#{ssh_directory}" do
  owner username
  group group
  mode '0700'
end

cookbook_file "#{ssh_directory}/id_rsa.pub" do
  owner username
  group group
  mode '0644'
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
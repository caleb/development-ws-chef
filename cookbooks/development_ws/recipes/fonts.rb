remote_directory "/home/#{node[:username]}/.fonts" do
  source 'fonts'
  owner node[:username]
  group node[:username]
  mode '0755'
  files_mode '0644'
end

bash 'change ownership of fonts directory' do
  code <<-BASH
    chown -R #{node[:username]}:#{node[:username]} /home/#{node[:username]}/.fonts
  BASH
end

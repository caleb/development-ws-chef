username = node[:username]
password = node[:secrets][:password]

package 'samba'

cookbook_file '/etc/samba/smb.conf' do
  source 'smb.conf'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'smbd' do
  subscribes :reload, 'cookbook_file[/etc/samba/smb.conf]', :immediately
end

bash "add the #{username} samba user" do
  code <<-BASH
    (echo "#{password}"; echo "#{password}") | smbpasswd -a -s #{username}
  BASH
end
require 'digest'

package 'zsh'

username = node[:username]
password = node[:secrets][:password]
salt = node[:secrets][:salt]
password_hash = password.crypt("$6$#{salt}")

user 'caleb' do
  action :manage
  shell '/usr/bin/zsh'
  password password_hash
end

username = node[:username]

group 'sudo' do
  action :manage
  append true
  members username
end

group 'docker' do
  action :manage
  append true
  members username
end

group 'sudo' do
  action :manage
  append true
  members 'caleb'
end

group 'docker' do
  action :manage
  append true
  members 'caleb'
end
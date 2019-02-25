package [ 'postfix', 'mailx' ] do
  action :install
end

package 'redis' do
  action :nothing
  notifies :start, 'service[redis]', :immediately
end

package 'epel-release' do
  action :install
  notifies :install, 'package[redis]', :immediately
end

service 'redis' do
  supports status: true, restart: true, reload: true
  action :enable
end  

package 'python-pip' do
  notifies :run, 'execute[pip install redis]'
end

execute 'pip install redis' do
  command 'pip install redis'
  action :nothing
end

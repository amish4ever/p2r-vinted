conf_array = %w[main.cf master.cf]

conf_array.each do |this_config|
  cookbook_file '/etc/postfix/' + this_config do
    source this_config
    notifies :restart, 'service[postfix]'
  end
end

service 'postfix' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

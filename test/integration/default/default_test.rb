# # encoding: utf-8

# Inspec test for recipe p2r-vinted::default
pack_array = [
'redis',
'postfix',
'mailx']

serv_array = [
'redis',
'postfix']

script_array = [
'store_mail.py',
'get_mail.py']

mail_array = [
'main.cf',
'master.cf']

pack_array.each do |this_pack|
  describe package(this_pack) do
    it { should be_installed }
  end
end

describe pip('redis') do
  it { should be_installed }
end

serv_array.each do |this_serv|
  describe service(this_serv) do
    it { should be_enabled }
    it { should be_running }
  end
end

script_array.each do |this_script|
  describe file('/usr/sbin/' + this_script) do
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'root' }
    its('size') { should > 0 }
  end
end

mail_array.each do |this_mail|
  describe file('/etc/postfix/' + this_mail) do
    its('content') { should match /mail2redis/ }
  end
end

describe bash('echo Testing | mail -s test root') do
  its('exit_status') { should eq 0 }
end

describe bash('sleep 20 && if [ `redis-cli --raw hget 1 Message:` == \'Testing\' ]; then (exit 0); else (exit 1); fi') do
  its('exit_status') { should eq 0 }
end

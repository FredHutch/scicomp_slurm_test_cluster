#
# Cookbook:: scicomp_slurm_test_cluster
# Recipe:: database
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# install and configure the server

mysql_service 'default' do
  version '5.7'
  bind_address '127.0.0.1'
  initial_root_password node['slurm_test_cluster']['mysql_password']
  action [:create, :start]
end

execute 'create slurm user' do
  command '/usr/bin/mysql -u root ' \
    "-p#{node['slurm_test_cluster']['mysql_password']} " \
    '-D mysql -r -B -N -h 127.0.0.1 -e ' \
    '"CREATE USER \'slurm\'@\'localhost\' ' \
    "IDENTIFIED BY '#{node['slurm_test_cluster']['mysql_password']}'\""
  action :run
  only_if do
    `/usr/bin/mysql -u root -p#{node['slurm_test_cluster']['mysql_password']} -D mysql -r -B -N -h 127.0.0.1 -e "SELECT COUNT(*) FROM user WHERE USER = 'slurm' AND HOST = 'localhost'"`.to_i.zero?
  end
end

execute 'create slurm grants' do
  command '/usr/bin/mysql -u root ' \
    "-p#{node['slurm_test_cluster']['mysql_password']} " \
    '-D mysql -r -B -N -h 127.0.0.1 -e ' \
    '"GRANT ALL ON slurm_acct_db TO \'slurm\'@\'localhost\'"'
  action :run
  not_if do
    `/usr/bin/mysql -u root -p#{node['slurm_test_cluster']['mysql_password']} -D mysql -r -B -N -h 127.0.0.1 -e "SELECT COUNT(*) FROM user WHERE USER = 'slurm' AND HOST = 'localhost'"`.to_i.zero?
  end
end

execute 'create slurm account database' do
  command '/usr/bin/mysql -u root ' \
    "-p#{node['slurm_test_cluster']['mysql_password']} " \
    '-D mysql -r -B -N -h 127.0.0.1 -e ' \
    '"CREATE DATABASE slurm_acct_db"'
  action :run
end

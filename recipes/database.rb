#
# Cookbook:: scicomp_slurm_test_cluster
# Recipe:: database
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# rubocop:disable Metrics/LineLength

# install and configure the server

mysql_service 'default' do
  version node['slurm_test_cluster']['mysql']['version']
  bind_address node['slurm_test_cluster']['mysql']['bind_address']
  initial_root_password node['slurm_test_cluster']['mysql']['password']
  action [:create, :start]
end

execute 'sleep timer' do
  command 'sleep 10'
end

execute 'create slurm user' do
  command '/usr/bin/mysql -u root ' \
    "-p#{node['slurm_test_cluster']['mysql']['password']} " \
    '-D mysql -r -B -N -S /run/mysql/mysqld.sock -e ' \
    '"CREATE USER \'slurm\'@\'127.0.0.1\' ' \
    "IDENTIFIED BY '#{node['slurm_test_cluster']['mysql']['password']}'\""
  action :run
  only_if do
    `/usr/bin/mysql -u root -p#{node['slurm_test_cluster']['mysql']['password']} -D mysql -r -B -N -S /run/mysql/mysqld.sock -e "SELECT COUNT(*) FROM user WHERE USER = 'slurm' AND HOST = '127.0.0.1'"`.to_i.zero? # ~FC048
  end
end

execute 'create slurm grants' do
  command '/usr/bin/mysql -u root ' \
    "-p#{node['slurm_test_cluster']['mysql']['password']} " \
    '-D mysql -r -B -N -S /run/mysql/mysqld.sock -e ' \
    '"GRANT ALL ON slurm_acct_db.* TO \'slurm\'@\'127.0.0.1\'"'
  action :run
  not_if do
    `/usr/bin/mysql -u root -p#{node['slurm_test_cluster']['mysql']['password']} -D mysql -r -B -N -S /run/mysql/mysqld.sock -e "SELECT COUNT(*) FROM user WHERE USER = 'slurm' AND HOST = '127.0.0.1'"`.to_i.zero? # ~FC048
  end
end

execute 'create slurm account database' do
  command '/usr/bin/mysql -u root ' \
    "-p#{node['slurm_test_cluster']['mysql']['password']} " \
    '-D mysql -r -B -N -S /run/mysql/mysqld.sock -e ' \
    '"CREATE DATABASE slurm_acct_db"'
  action :run
  not_if do
    `/usr/bin/mysql -u root -p#{node['slurm_test_cluster']['mysql']['password']} -D mysql -r -B -N -S /run/mysql/mysqld.sock -e "SHOW DATABASES LIKE 'slurm_acct_db'"`.chomp == 'slurm_acct_db' # ~FC048
  end
end

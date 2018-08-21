#
# Cookbook:: scicomp_slurm_test_cluster
# Recipe:: config
#
# Copyright:: 2018, The Authors, All Rights Reserved.

directory '/var/spool/slurm-llnl' do
  owner 'root'
  group 'root'
  mode '0755'
end

directory '/var/spool/slurm-llnl/slurmctld' do
  owner 'slurm'
  group 'slurm'
  mode '0755'
end

(1..10).each do |i|
  directory "/var/spool/slurm-llnl/slurmd.node#{i}" do
    owner 'root'
    group 'root'
    mode '0755'
  end
end

template '/etc/slurm-llnl/slurm.conf' do
  source 'slurm.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    hostname: node['hostname'],
    ClusterName: node['slurm_test_cluster']['ClusterName']
  )
end

template '/etc/slurm-llnl/slurmdbd.conf' do
  source 'slurmdbd.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    DbdHost: node['hostname'],
    ClusterName: node['slurm_test_cluster']['ClusterName'],
    StoragePass: node.default['slurm_test_cluster']['mysql_password']
  )
end

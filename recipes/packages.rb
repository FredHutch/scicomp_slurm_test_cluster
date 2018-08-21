#
# Cookbook:: scicomp_slurm_test_cluster
# Recipe:: packages
#
# Copyright:: 2018, The Authors, All Rights Reserved.

group 'slurm' do
  gid '6281'
end

user 'slurm' do
  comment 'slurm-wlm user account'
  uid '6281'
  gid '6281'
  home '/var/spool/slurm-llnl'
  shell '/bin/bash'
end

package_list = %w(
  libslurm33
  libslurmdb33
  slurm-client
  slurm-wlm-basic-plugins
  slurmctld
  slurmd
  slurmdbd
)

apt_package package_list do
  options '--allow-unauthenticated'
end

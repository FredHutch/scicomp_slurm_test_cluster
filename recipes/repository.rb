#
# Cookbook:: scicomp_slurm_test_cluster
# Recipe:: repository
#
# Copyright:: 2018, Fred Hutchinson Cancer Research Center, All Rights Reserved.

# Set up a repository on the local file system.  Source information
# here:
#   https://askubuntu.com/a/176546 
#   https://help.ubuntu.com/community/Repositories/Personal

# Install dpkg utilities

package 'dpkg-dev'

# Create source directory

directory '/export/packages/slurm' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
end

# TBD: add something to add packages from external source

# Build package index
execute 'build packages.gz' do
  command 'dpkg-scanpackages . /dev/null > Packages'
  #command 'dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz'
  cwd '/export/packages/slurm'
  user 'root'
  umask '0022'
end

# Add entry in apt sources

apt_repository 'local' do
  uri 'file:///export/packages/slurm'
  distribution './'
end

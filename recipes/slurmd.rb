#
# Cookbook:: scicomp_slurm_test_cluster
# Recipe:: slurmd
#
# Copyright:: 2018, The Authors, All Rights Reserved.

(1..10).each do |i|
  execute "slurmd node# #{i}" do
    command "/usr/sbin/slurmd -N node#{i}"
    not_if "ps -ef |grep -v grep |grep \"/usr/sbin/slurmd -N node#{i}\""
    # This doesn't work for some reason- always skips...
    # not_if "pgrep -f \"/usr/sbin/slurmd -N node#{i}\""
  end
end

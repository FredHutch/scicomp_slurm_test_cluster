name 'scicomp_slurm_test_cluster'
maintainer 'Hutch Build Automator'
maintainer_email 'mrg+btb@fredhutch.org'
license 'All Rights Reserved'
description 'Installs/Configures scicomp_slurm_test_cluster'
long_description 'Installs/Configures scicomp_slurm_test_cluster'
version '0.2.9'
chef_version '>= 12.1' if respond_to?(:chef_version)
supports 'ubuntu'
# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/fredhutch/scicomp_slurm_test_cluster/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/fredhutch/scicomp_slurm_test_cluster'

depends 'mysql', '~> 8.0'

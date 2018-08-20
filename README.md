# scicomp_slurm_test_cluster

Configures a single node cluster for verification of our Slurm packages (i.e. installation and basic function).  Configures:

- a local Apt repo with desired packages
- a local MySQL database
- the database (`slurm_acct_db`) and necessary slurm "grants" to that database
- Necessary slurm packages and dependencies
- Slurm configs

The configurations are somewhat FredHutch centered as it configures job submit
plugins used here.

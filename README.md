# scicomp_slurm_test_cluster

Configures a single node cluster for verification of our Slurm packages (i.e. installation and basic function).  Configures:

- a local Apt repo with desired packages
- a local MySQL database
- the database (`slurm_acct_db`) and necessary slurm "grants" to that database
- Necessary slurm packages and dependencies
- Slurm configs

The configurations are somewhat FredHutch centered as it configures job submit
plugins used here.

Notes:

For passwords, use the file `attributes/passwords.rb`  This file isn't included
in git so it's reasonable for the intended use of this cookbook (i.e. for pure
test).

The required passwords are:

```
node.default['slurm_test_cluster']['mysql_password'] = 'password'
```

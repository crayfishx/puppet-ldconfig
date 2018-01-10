# ldconfig

## Description

A simple module to manage ld.conf.d entries on Unix systems.  This has been tested on RHEL.

## Usage Example

This module contains a defined resource type called `ldconfig::entry` which will generate a file in `/etc/ld.so.conf.d` and run the `ldconfig` command when something in that content changes.  The main ldconfig base class also can read in entries from Hiera and generate entries.

### In Puppet DSL

```puppet
  ldconfig::entry { 'mariadb':
    paths => [ '/usr/lib64/mysql' ]
  }
```

### In Hiera

Hiera can be populated with the `ldconfig::entries` hash to automatically generate entries from data

```yaml
ldconfig::entries:
  mariadb:
    paths:
      - /usr/lib64/mysql
```

## Reference
    
### Class `ldconfig`

The base `ldconfig` class accepts the following parameters

* `ld_conf_dir`: Directory containing ld.so.conf files, default: `/etc/ld.so.conf.d`
* `ldconfig_exec`: Path to the command to run upon change, default: `/sbin/ldconfig`
* `run_ldconfig`: True or false, whether or not to run the ldconfig command upon change (default: true)
* `entries`: A hash of entries to generate (see Hiera example above)

### Defined type `ldconfig::entry`

The `ldconfig::entry` defined resource type accepts the following parameters

* `ensure`:  Present or absent, default: present
* `paths`: An array of path names


## Maintainer
This module is written and maintained by Craig Dunn <craig@craigdunn.org> (@crayfishx)

## License
See the NOTICE and LICENSE files.  This module is licensed under Apache 2.0




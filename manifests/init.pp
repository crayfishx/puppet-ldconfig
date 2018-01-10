# Copyright 2018 Craig Dunn
#
# See README for documentation on class parameters.
#
class ldconfig (
  String  $ld_conf_dir   = '/etc/ld.so.conf.d',
  String  $ldconfig_exec = '/sbin/ldconfig',
  Boolean $run_ldconfig  = true,
  Hash    $entries       = {}
) {

  $entries.each | String $ld_title, Hash $ld_params | {
    ldconfig::entry { $ld_title:
      * => $ld_params
    }
  }

  exec { 'ldconfig::exec':
    command     => $ldconfig_exec,
    refreshonly => true,
  }
}

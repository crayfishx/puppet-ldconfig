define ldconfig::entry (
  String                    $target = "${name}.conf",
  Enum['present', 'absent'] $ensure = 'present',
  Array[Stdlib::Unixpath]   $paths  = [],
) {

  include ::ldconfig

  file { "${ldconfig::ld_conf_dir}/${target}":
    ensure      => $ensure ? {
      'present' => 'file',
      'absent'  => 'absent',
    },
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $paths.sort.join("\n"),
    notify  => $ldconfig::run_ldconfig ? {
      true  => Exec['ldconfig::exec'],
      false => undef,
    }
  }

}

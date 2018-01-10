# Defined resource type for creating ldconfig entries, see
# README for documentation on Parameters
#
define ldconfig::entry (
  String                    $target = "${name}.conf",
  Enum['present', 'absent'] $ensure = 'present',
  Array[Stdlib::Unixpath]   $paths  = [],
) {

  include ::ldconfig

  $file_ensure = $ensure ? {
    'present' => 'file',
    'absent'  => 'absent',
  }

  file { "${ldconfig::ld_conf_dir}/${target}":
    ensure  => $file_ensure,
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

# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include spectrum_protect_client
# @param packages [Hash] Hash of package resource definitions to manage as part of the class
# @param default_package_action [String] Default value of ensure if not specified for a package
class spectrum_protect_client (
  Hash[String,Hash] $packages,
  String $version,
  Enum['latest','installed','absent'] $default_package_action,
) {
  $packages.each | $package,$params | {
    $_params = { 'ensure' => $default_package_action } + $params
    # Upgrading BA packages should only be done when needed
    yum::versionlock { "0:${package}-${version}":
      ensure => present,
    } -> package { $package:
      * => $_params,
    }
  }
}

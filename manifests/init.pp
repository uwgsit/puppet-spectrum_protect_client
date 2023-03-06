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
  Enum['latest','installed','absent'] $default_package_action,
) {
  $packages.each | $package,$params | {
    $_params = { 'ensure' => $default_package_action } + $params
    package { $package:
      * => $_params,
    }
  }
}

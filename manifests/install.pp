# = Class: nagios_twilio::install
#
# This class does stuff that you describe here.
# Change Class to Define if needed.
#
# == Requirements:
#
# - This module requires
#
# == Parameters
#
# [* ensure *]
#   What state to ensure for the module.
#   Default: present
#
# == Variables
#
# == Examples
#
# == Author
#

class nagios_twilio::install {

  package { [
    'perl-JSON',
    'perl-IO-Socket-SSL',
  ]: }

  case $::operatingsystem {
    /^(RedHat|CentOS)$/: {
      package { 'perl-libwww-perl': }
    }
    'Fedora': {
      package { 'perl-LWP-Protocol-https': }
    }

  }

  $path = '/usr/local/bin/twilio-sms'

  file { $path:
    ensure => file,
    source => 'puppet:///modules/nagios_twilio/twilio-sms',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  nagios_command { 'notify-service-by-twilio':
    command_line => "/usr/bin/printf \"%b\" \"Service: \$SERVICEDESC\$\\nHost: \$HOSTALIAS\$\\nState: \$SERVICESTATE\$\\nNagios: ${::hostname}\\n\\n\$SERVICEOUTPUT\$\" | ${path} -- \$CONTACTPAGER\$"
  }

  nagios_command { 'notify-host-by-twilio':
    command_line => "/usr/bin/printf \"%b\" \"Host: \$HOSTNAME\$\\nState: \$HOSTSTATE\$\\nNagios: ${::hostname}\\n\\n\$HOSTOUTPUT\$\" | ${path} -- \$CONTACTPAGER\$"
  }

}

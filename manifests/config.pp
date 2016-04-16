# = Class: nagios_twilio::config
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
class nagios_twilio::config (
  $user_id=undef,
  $auth_token=undef,
  $from=undef,
) {

  if (! $user_id) {
    fail('Please specify nagios_twilio::config::user_id')
  }
  $deferred_dir = '/var/spool/twilio-sms'

  file { $deferred_dir:
    ensure  => 'directory',
    owner   => 'nagios',
    group   => 'nagios',
    mode    => '0750',
  }

  file { '/etc/nagios/twilio-sms.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'nagios',
    mode    => '0640',
    content => template('nagios_twilio/twilio-sms.conf.erb'),
  }

}

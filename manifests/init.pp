# = Class: nagios_twilio
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
class nagios_twilio {
  include nagios_twilio::install
  include nagios_twilio::config
}


#####
# This class is for the Apache-Plugin of collectd. It's a bit different than the other
# plugins, because it's very complex.
#####

class collectd::plugin::apache {

	collectd::plugin::include{"apache":
		pluginsection   => "true",
	}


	define instance (
			$url = 'http://localhost/server-status?auto',
			$auth_user = '',
			$auth_password = ''
			){

		$apache_filename = regsubst($name, "([^a-zA-Z0-9])", "","G")

		# Since debian squeeze --> create instance-tag
		if $::lsbdistid == 'Debian' and $::lsbmajdistrelease > 5 {
			common::concatfilepart { "222_${apache_filename}_111":
				file    => "${collectd::conf_path}/plugins/apache.conf",
				content => inline_template("<Instance \"${apache_filename}\"> \n"),
			}
		}

		common::concatfilepart { "222_${apache_filename}_222":
			file    => "${collectd::conf_path}/plugins/apache.conf",
			content => inline_template("URL \"${url}\" \n"),
		}

		if $auth_user != "" {

			common::concatfilepart { "222_${apache_filename}_333":
				file    => "${collectd::conf_path}/plugins/apache.conf",
				content => inline_template("User \"${auth_user}\" \n"),
			}
		}

		if $auth_password != "" {

			common::concatfilepart { "222_${apache_filename}_444":
				file    => "${collectd::conf_path}/plugins/apache.conf",
					content => inline_template("Password \"${auth_password}\" \n"),
			}
		}

		# Since debian squeeze --> create instance-tag
		if $::lsbdistid == 'Debian' and $::lsbmajdistrelease > 5 {
			common::concatfilepart { "222_${apache_filename}_999":
				file    => "${collectd::conf_path}/plugins/apache.conf",
				content => inline_template("</Instance> \n"),
			}
		}
	} # define instance

} # collectd::plugin::apache

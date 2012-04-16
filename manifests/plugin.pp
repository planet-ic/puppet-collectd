#####
# This class activates and configures a special plugin for collectd. Some plugins need a special
# configuration. Therefor we put some classes in the plugin directory.
#####

class collectd::plugin {
	define include (
		$pluginsection	= "false",
		$extra_content = false
		) {
			# Config-file of the plugin that contain all configurations of a special plugin
			file { "${collectd::conf_path}/plugins/${name}.conf":
				ensure  => present,
				owner   => root,
				group   => root,
				mode    => 644,
				notify  => Service['collectd'],
				require => Package["collectd"],
			}
			# This directory is need to handle the parts of the config-file.
			file { "${collectd::conf_path}/plugins/${name}.conf.d":
				ensure  => directory,
				owner   => root,
				group   => root,
				mode    => 755,
				force   => true,
				purge   => true,
				recurse => true,
				require	=> Package["collectd"],
			}

			if $extra_content == false {
				/* Easy plugin-loading via LoadPlugin-row */
				common::concatfilepart { "000_${name}_load":
					file    => "${collectd::conf_path}/plugins/${name}.conf",
						content => inline_template("LoadPlugin \"${name}\" \n"),
						require	=> Package["collectd"],
						notify  => Service['collectd'],
				}
			} else {
				/* creates <LoadPlugin XYZ>-section */
				common::concatfilepart { "000_${name}_load":
					file    => "${collectd::conf_path}/plugins/${name}.conf",
						content => inline_template("<LoadPlugin ${name}>\n${extra_content}\n</LoadPlugin>\n"),
						require	=> Package["collectd"],
						notify  => Service['collectd'],
				}
			}
			/* create plugin-Section, if need */
			if $pluginsection == "true" {
				section { "${name}": plugin => "${name}" }
			}
	} # define include

	/**
	 * creates a new <Plugin ... >-section
	 */
	define section ($plugin,$startprio=111,$endprio=999) {

		common::concatfilepart { "${startprio}_${name}_0header":
			file    => "${collectd::conf_path}/plugins/${plugin}.conf",
				content => inline_template("<Plugin \"${plugin}\"> \n"),
				require => Package["collectd"],
		}

		common::concatfilepart { "${endprio}_${name}_~footer":
			file    => "${collectd::conf_path}/plugins/${plugin}.conf",
				content => inline_template("</Plugin> \n"),
				require => Package["collectd"],
		}
	} # define section

	define confline (
			$plugin,
			$order="200",
			$content
			){
		common::concatfilepart { "${order}_${name}":
			file    => "${collectd::conf_path}/plugins/${plugin}.conf",
			content => inline_template("${content}\n"),
			require => Package["collectd"],
		}
	} # define confline

} # class collectd::plugin

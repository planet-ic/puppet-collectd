#####
# This plugin configures the df-plugin of collectd.
#####

class collectd::plugin::df (
		$root_device	= "/dev/simfs",
		$root_fs_type	= "simfs",
		$root_ignore_selected = false,
		$root_report_reserved = false,
		$root_report_inodes   = false
		){

	collectd::plugin::include{"df":
		pluginsection   => "false",
	}

	partition { "/": 
		device => $root_device,
		fs_type => $root_fs_type,
		ignore_selected => $root_ignore_selected,
		report_reserved => $root_report_reserved,
		report_inodes => $root_report_inodes
	}

	define partition (
		$device,
		$fs_type,
		$ignore_selected = false,
		$report_reserved = false,
		$report_inodes = false
		){

		# $name = / (mountpoint)
		$pname = regsubst($name, '/', '--', 'G')
		$fname = regsubst($pname, '[^a-zA-Z0-9-]', '_', 'G')

		# section erstellen
		collectd::plugin::section{ "${fname}": 
			plugin => "df",
			startprio => 222,
			endprio => 222
		}
		# defaultwerte
		Collectd::Plugin::Confline { order   => 222, plugin  => "df" }
		# config erstellen
		collectd::plugin::confline{"${fname}_device": 		content => "  Device \"${device}\"" }
		collectd::plugin::confline{"${fname}_mountpoint":	content => "  MountPoint \"${name}\"" }
		collectd::plugin::confline{"${fname}_fstype": 		content => "  FSType \"${fs_type}\"" }
		collectd::plugin::confline{"${fname}_ignore_selected":
			content => $ignore_selected ? {
				true    => "  IgnoreSelected true" ,
				default => "  IgnoreSelected false"
			}
		}
		# Funktionieren nur ab Version 4.9
		if $::lsbdistid == "Debian" and $::lsbmajdistrelease > 5 {
			# erst ab Squeeze
			collectd::plugin::confline{"${fname}_report_reserved":
				content => $report_reserved ? {
					true    => "  ReportReserved true" ,
						default => "  ReportReserved false"
				}
			}
			collectd::plugin::confline{"${fname}_report_inodes":
				content => $report_inodes ? {
					true    => "  ReportInodes true" ,
						default => "  ReportInodes false"
				}
			}
		}
	}
} # class collectd::plugin::df

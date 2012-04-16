#####
# This class configures the syslog-plugin of collectd.
#####

class collectd::plugin::syslog (
		$syslog_loglevel	= "info"
		){
	collectd::plugin::include{"syslog":
		pluginsection	=> "true",
	}

	collectd::plugin::confline{"syslog_loglevel":
		order	=> 222,
		plugin	=> "syslog",
		content	=> "LogLevel \"${syslog_loglevel}\"",
	}
} # class collectd::plugin::syslog

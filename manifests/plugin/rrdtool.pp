#####
# This class configures the rrdtool-plugin of collectd.
#####

class collectd::plugin::rrdtool(
		$rrdtool_data_dir		= "/var/lib/collectd/rrd",
		$rrdtool_cache_flush		= "120",
		$rrdtool_writes_per_second	= "50"
		) {

	collectd::plugin::include{"rrdtool":
		pluginsection   => "true",
	}		

	collectd::plugin::confline{"rrdtool_data_dir":
		order   => 222,
		plugin  => "rrdtool",
		content => "DataDir \"${rrdtool_data_dir}\"",
	}

	collectd::plugin::confline{"rrdtool_cache_flush":
		order   => 223,
		plugin  => "rrdtool",
		content => "CacheFlush ${rrdtool_cache_flush}",
	}

	collectd::plugin::confline{"rrdtool_writes_per_second":
		order   => 224,
		plugin  => "rrdtool",
		content => "WritesPerSecond ${rrdtool_writes_per_second}",
	}
} # class collectd::plugin::rrdtool

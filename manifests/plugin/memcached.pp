#####
# This class configures the memcached-plugin of collectd.
#####

class collectd::plugin::memcached (
		$host	= "127.0.0.1",
		$port	= "11211"
		){
	collectd::plugin::include{"memcached":
		pluginsection   => "true",
	}

	collectd::plugin::confline{"memcached_host":
		order   => 222,
		plugin  => "memcached",
		content => "Host \"${host}\"",
	}
	collectd::plugin::confline{"memcached_port":
		order   => 223,
		plugin  => "memcached",
		content => "Port \"${port}\"",
	}
} # class collectd::plugin::memcached


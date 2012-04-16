#####
# This class configures the memory-plugin of collectd.
#####

class collectd::plugin::memory{
	collectd::plugin::include{"memory":
		pluginsection   => "false",
	}
} # collectd::plugin::memory

#####
# This class configures the load-plugin of collectd.
#####

class collectd::plugin::load{
	collectd::plugin::include{"load":
		pluginsection   => "false",
	}
} # collectd::plugin::load


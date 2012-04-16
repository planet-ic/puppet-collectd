#####
# This class configures the cpu-plugin of collectd
#####

class collectd::plugin::cpu {
	collectd::plugin::include{"cpu":
		pluginsection   => "false",
	}
} # define collectd::plugin::cpu

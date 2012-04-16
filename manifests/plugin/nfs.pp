#####
# This class configures the nfs-plugin of collectd. 
#####

class collectd::plugin::nfs {
	collectd::plugin::include{"nfs":
		pluginsection   => "false",
	}
} # class collectd::plugin::nfs


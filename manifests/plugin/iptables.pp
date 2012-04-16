#####
# This class configures the iptables-plugin of collectd.
#####

class collectd::plugin::iptables (
		$comment	= "Accounting",
		$table	= "filter"
		){
	collectd::plugin::include{"iptables":
		pluginsection   => "true",
	}

	collectd::plugin::confline{"iptables_${table}_${comment}":
		order   => 222,
		plugin  => "iptables",
		content => "Chain ${table} ${comment}",
	}
} # class collectd::plugin::iptables

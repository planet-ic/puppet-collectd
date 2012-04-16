#####
# This class configures the network-plugin of collectd.
#####

class collectd::plugin::network (
		$listen_ip	= "${::ipaddress}",
		$server_ip	= "",
		$port		= "25826",
		$server		= "false",
		$client		= "false"
		){
	collectd::plugin::include{"network":
		pluginsection   => "true",
	}

	if $server == "true" {
		collectd::plugin::confline{"network_listen_content":
			order   => 222,
			plugin  => "network",
			content => "Listen \"${listen_ip}\" \"${port}\"",
		}
	}

	if $client == "true" {
		collectd::plugin::confline{"network_listen_content":
			order   => 222,
			plugin  => "network",
			content => "Server \"${server_ip}\" \"${port}\"",
		}
	}
} # class collectd::plugin::network

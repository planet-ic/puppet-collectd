#####
# This class configures the tcpconns-plugin of collectd.
#####

class collectd::plugin::tcpconns (
		listening_ports	= "false",
		local_port	= "80",
		remote_port	= "80"
		){
	collectd::plugin::include{"tcpconns":
		pluginsection   => "true",
	}

	collectd::plugin::confline{"tcpconns_listening_ports":
		order   => 222,
		plugin  => "tcpconns",
		content => "ListeningPorts ${listening_ports}",
	}
	collectd::plugin::confline{"tcpconns_local_port_${local_port}":
		order   => 222,
		plugin  => "tcpconns",
		content => "LocalPort \"${local_port}\"",
	}
	collectd::plugin::confline{"tcpconns_remote_port_${remote_port}":
		order   => 222,
		plugin  => "tcpconns",
		content => "RemotePort \"${remote_port}\"",
	}
} # class collectd::plugin::tcpconns

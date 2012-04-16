#####
# This class configures a collectd-server. There are some plugins loaded,
# that we see to be needed for a collectd-server.
#####

class collectd::server (
	$collectd_listen_address	= ["${::ipaddress}"],
	$collectd_listen_port   	= "25826",
	$collectd_syslog_loglevel	= "info"
	){
	
	include collectd
	class {"collectd::plugin::network":
		server	=> "true",
	}
	class{"collectd::plugin::rrdtool":}
	class{"collectd::plugin::cpu":}
	class{"collectd::plugin::memory":}
	class{"collectd::plugin::syslog":
		syslog_loglevel	=> $collectd_syslog_loglevel,
	}
	class{"collectd::plugin::load":}
} # class collectd::server

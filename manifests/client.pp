#####
# This class is for a collectd client. There are some plugins loaded,
# that we see to be needed for a collectd-client.
#####

class collectd::client (
	$server_ip,
	$port			= "25826",
	$syslog_loglevel	= "info"
	){

	include collectd
	class {"collectd::plugin::network":
		server_ip	=> $server_ip,
		client		=> "true",
		port		=> $port,
	}
	class {"collectd::plugin::cpu":}
	class {"collectd::plugin::memory":}
	class {"collectd::plugin::syslog":
		syslog_loglevel	=> $syslog_loglevel,
	}
	class {"collectd::plugin::load":}	
} # class collectd::client

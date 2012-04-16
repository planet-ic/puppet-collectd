#####
# Thjis class configures the haproxy-plugin of collectd.
#####

class collectd::plugin::haproxy($socket="/var/run/haproxy.sock") {


	file { "/etc/collectd/lib":
		ensure => directory
	}

        file { "/etc/collectd/lib/haproxy.py":
                source => "puppet:///modules/corefiles/collectd/haproxy.py",
                owner => root,
                group => root,
                mode => 644,
		require => File["/etc/collectd/lib"]
        }

        class { "collectd::plugin::python": }

        collectd::plugin::python::module{ "haproxy": 
		content => "Socket \"${socket}\"",
		require => File["/etc/collectd/lib/haproxy.py"]
	}	
}


#
#
#

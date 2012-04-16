#####
# Collectd Module for puppet
# 
# This is the main class of the puppet-collectd module. 
# It installs and configures collectd. It doesn't configure the modules for collectd. 
# Therefor you have to use the other classes.
#####

class collectd(
	# class variables
	$conf_path      	= "/etc/collectd",
	$collectd_fqdnlookup	= "true"
	){
	# install collectd package
	package { "collectd":
		ensure	=> installed,
	}
	# generates collectd service for puppet
	service { "collectd":
		ensure		=> running,
		require		=> Package['collectd'],
		hasrestart 	=> true,
	}
	# generates collectd.conf
	file { "${conf_path}/collectd.conf":
		ensure  => present,
		owner   => root,
		group   => root,
		mode    => 644,
		require => Package['collectd'],
		notify	=> Service['collectd'],
        }
	# creates the plugin dir, that is used for all other configs of the plugins
	file { "${conf_path}/plugins":
		ensure	=> directory,
		owner	=> root,
		group	=> root,
		mode	=> 755,
		recurse => true, 
                purge   => true, 
                force   => true, 
		notify	=> Service['collectd'],
		require => Package['collectd'],
	}
	# creates the threasholds dir
	file { "${conf_path}/thresholds":
                ensure  => directory,
                owner   => root,
                group   => root,
                mode    => 755,
                recurse => true, 
                purge   => true, 
                force   => true, 
		require => Package['collectd'],
                notify  => Service['collectd'],
        }
	# enable/disable FQDN Lookup 
	common::concatfilepart { "444_FQDNLookup":
		file	=> "${conf_path}/collectd.conf",
		content	=> inline_template("FQDNLookup ${collectd_fqdnlookup} \n"),
		require => Package['collectd'],
	}
	# include plugins
	common::concatfilepart { "555_plugin":
		file    => "${conf_path}/collectd.conf",
		content	=> inline_template("Include \"${conf_path}/plugins/*.conf\" \n"),
		require => Package['collectd'],
	}
} # class collectd

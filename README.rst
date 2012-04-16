=====================================
How to configure the collectd-module:
=====================================

There are 2 different nodes consisting collectd. There is a server-node and 
a client-node. The server node is easy to configure. Just write this text
in your puppet-node:

    class { "collectd::server":}

For the client-node you have to write the following:

    collectd::plugin::network::client { "network-client":

    collectd_server_address    => ["IP.OF.YOUR.COLLECTDSERVER"],	

    }	

If you want to use one of the plugins, that are not mentioned in the server-/client-node,
you have to load the class of the plugin in the puppet-node:

    class { "collectd::plugin::NAME-OF-THE-PLUGIN": }

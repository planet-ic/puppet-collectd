#####
# This plugin configures the fscache-plugin of collectd.
#####

class collectd::plugin::fscache {
        collectd::plugin::include{"fscache":
                pluginsection   => "false",
        }
} # class collectd::plugin::fscache


#####
# This class configures the python-plugin of collectd.
#####

class collectd::plugin::python (
		$globals = true,
		$libdir = '/etc/collectd/lib'
		){

	collectd::plugin::include{"python":
		pluginsection   => "true",
		extra_content 	=> $globals ? {
			true => "Globals true",
			false => false
		}
	}

	collectd::plugin::confline{"python__libs":
		order   => 222,
		plugin  => "python",
		content => "ModulePath \"$libdir\"",
	}

	define module($content) {
		/* Standardwerte definieren */
		Collectd::Plugin::Confline { plugin  => "python", order   => 222, }

		/* Pyhton-Modul-Sektion */
		/* Start */
		collectd::plugin::confline{"python_module_-${name}":
			content => "Import \"${name}\"\n<Module ${name}>\n",
		}
		/* Ende */
		collectd::plugin::confline{"python_module_~${name}":
			content => "</Module>\n",
		}

		/* Content */
		collectd::plugin::confline{"python_module_content":
			content => $content,
		}
	}

} # class collectd::plugin::python

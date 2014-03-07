#
#   Send information about the resources that should be loaded 
#
namespace eval Startup::application-resource-bundle {

	jsonrpc'has-on-connect-callback

	proc on-connect {chan} {
		global config

		array set templates [find-templates "./public/assets/html"]
		set rel_scripts [find-files "./public/assets" "js"]

		set base_url "//wsapp.local/assets"
		foreach script $rel_scripts {
			lappend scripts "$base_url$rel_scripts"
		}

		foreach js $config(javascript) {
			lappend scripts $js
		}


		#
		#    Send a list of styles and javascripts to load before we can kick off properly!
		#
		Websocket::send-message $chan [jsonrpc'message "load-resources" [list \
			styles 			[j'list $config(styles)] \
			javascripts		[j'list $scripts] \
			templates		[json::array templates]
		]]

	}

}


namespace eval Action::load-complete {

	#
	#	Callback called when initial load has been completed.
	#
	proc on-message {chan data} {
		puts "Another map, fully loaded!"
		# Websocket::send-message $chan [jsonrpc'message "script" [list content [j' {

		# 		// javascript code
		# 		console.log("Loaded");

		# 	}]]
		# ]
	}

}
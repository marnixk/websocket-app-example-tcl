#
#   Send information about the resources that should be loaded when someone
#   connects to this application bundle.
#
namespace eval Startup::application-resource-bundle {

	jsonrpc'has-on-connect-callback

	proc on-connect {chan} {
		global config

		array set templates [find-templates "$config(assets)/html"]
		set rel_scripts [find-files "$config(assets)" "js"]

		lappend scripts

		# base library scripts
		foreach js $config(javascript) {
			lappend scripts $js
		}
		
		# local app bundle scripts
		set base_url "//wsapp.local/assets"
		foreach script $rel_scripts {
			lappend scripts "$base_url$script"
		}


		#
		#    Send a list of styles and javascripts to load before we can kick off properly!
		#
		Websocket::send-message $chan [jsonrpc'message "load-resources" [list \
			styles 			[j'list $config(styles)] \
			javascripts		[j'list $scripts] \
			templates		[json::array templates] \
			page			[j' $config(start-page)]
		]]

	}

}


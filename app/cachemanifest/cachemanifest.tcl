module CacheManifest {

	httpserver'path "/appcache.manifest"

	include HttpServer::HandlerBase

	#
	#	Send the headers of the cache manifest file
	#
	protected send-headers {chan} {
		global config

		if {$config(development-mode) == "true"} then {
			set latest "development mode enabled [clock microseconds]"
		} else {
			set latest $config(version)
		}

		puts $chan "HTTP/1.1 200 Modified"
		puts $chan "Content-Type: text/cache-manifest"
		puts $chan ""

		puts $chan "CACHE MANIFEST"
		puts $chan "# $latest"
		puts $chan ""
	}

	protected send-cached-files {chan files} {

		puts $chan "CACHE:"
		foreach asset $files {
			puts $chan $asset
		}

		puts $chan ""

	}

	protected send-network-behavior {chan} {
		puts $chan "NETWORK:"
		puts $chan "*"
		puts $chan ""

	}

	protected send-fallback {chan} {
		puts $chan "FALLBACK:"
		puts $chan ""

	}

	protected get-static-files {} {
		global config

		lappend files

		foreach asset $config(styles) {
			lappend files $asset
		}

		foreach asset $config(javascript) {
			lappend files $asset
		}

		set contexts [FileServeSocket::get-contexts-list]
		foreach context $contexts {
			set contextfiles [find-files $context "js"] 
			lappend contextfiles {*}[find-files $context "jpg"] 
			lappend contextfiles {*}[find-files $context "png"] 
			lappend contextfiles {*}[find-files $context "gif"] 
			lappend contextfiles {*}[find-files $context "css"] 

			foreach file $contextfiles {
				lappend files $file
				puts "found file to cache: $file"
			}
		}

		return $files
	}

	#
	#	Send the app-cache manifest
	#		
	public send-contents {chan} {

		set files [get-static-files]

		send-headers $chan
		send-cached-files $chan $files
		send-network-behavior $chan
		send-fallback $chan

		HttpServer::close $chan
	}

}



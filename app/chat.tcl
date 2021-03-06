#!/usr/bin/tclsh

foreach dir [glob "../packages/*"] {
	lappend auto_path $dir
}

package require json
package require httpserver
package require websockets
package require wsbootstrap
package require activetcl
package require validators
package require log


source'load { 
	"./utils" 
	"./actions" 
	"./model" 
	"./cachemanifest"
} 

# application bundle definition

# set config(version) 1.0

array set config {
	development-mode true

	styles {
		"//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"
		"//netdna.bootstrapcdn.com/bootswatch/3.1.1/lumen/bootstrap.min.css"
		"//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css"

		"/stylesheets/style.css"
	}

	javascript {
		"//code.jquery.com/jquery-2.1.0.min.js"
		"//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"
		"//ajax.googleapis.com/ajax/libs/angularjs/1.2.14/angular.min.js"
		"//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.6.0/underscore-min.js"
		"//cdnjs.cloudflare.com/ajax/libs/underscore.string/2.3.3/underscore.string.min.js"
	}

	start-page "nickname"
	wsport 8080

}

app'start

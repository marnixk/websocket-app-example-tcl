#!/usr/bin/tclsh

lappend auto_path [glob "/home/marnix/Programming/tcl/packages/*"]

package require json
package require websockets

source "files.tcl"

# application bundle definition
source "appbundle.tcl"

array set config {
	styles {
		"//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"
		"//netdna.bootstrapcdn.com/bootswatch/3.1.1/lumen/bootstrap.min.css"
		"//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css"
	}

	javascript {
		"//code.jquery.com/jquery-2.1.0.min.js"
		"//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"
		"https://ajax.googleapis.com/ajax/libs/angularjs/1.2.14/angular.min.js"
	}

	assets "./public/assets"
}


Websocket::start 1337 
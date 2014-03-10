#!/usr/bin/tclsh

lappend auto_path [glob "/home/marnix/Programming/tcl/packages/*"]

package require json
package require websockets

source "utils/files.tcl"
source "utils/apputil.tcl"

# actions 
source "actions/startup.tcl"
source "actions/load-complete.tcl"
source "actions/set-nickname.tcl"
source "actions/leave-chat.tcl"
source "actions/message.tcl"

# model
source "model/participants.tcl"

# application bundle definition

array set config {

	development-mode true

	styles {
		"//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"
		"//netdna.bootstrapcdn.com/bootswatch/3.1.1/lumen/bootstrap.min.css"
		"//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css"

		"/assets/stylesheets/style.css"
	}

	javascript {
		"//code.jquery.com/jquery-2.1.0.min.js"
		"//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"
		"//ajax.googleapis.com/ajax/libs/angularjs/1.2.14/angular.min.js"
		"//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.6.0/underscore-min.js"
		"//cdnjs.cloudflare.com/ajax/libs/underscore.string/2.3.3/underscore.string.min.js"
	}

	assets "../public/assets"
	start-page "nickname"
	wsport 1337

}

app'start
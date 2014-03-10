namespace eval Shutdown::LeaveChat {

	jsonrpc'has-on-close-callback

	#
	#	when someone leaves, make sure they are removed from the list
	#
	proc on-close {chan} {
		set name [Participant::name_for_chan $chan]
		if {$name != ""} then {
			Participant::left $chan
			Websocket::broadcast $chan [jsonrpc'message "left" [list name [j' $name]]]
		}
	}

}
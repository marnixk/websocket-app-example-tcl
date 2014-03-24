struct leftchat {
	name val
}

namespace eval Shutdown::LeaveChat {


	jsonrpc'has-on-close-callback

	#
	#	when someone leaves, make sure they are removed from the list
	#
	proc on-close {chan} {
		set name [Participant::name_for_chan $chan]
		if {$name != ""} then {
			Participant::left $chan
			
			# what to return
			set payload [create leftchat { name $name }]

			# send message
			Messagebus::notify "chat" [jsonrpc'message "left" $payload]
		}
	}

}
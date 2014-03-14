namespace eval Action::message {

	proc on-message {chan data} {
		array set data_arr $data
		array set payload $data_arr(payload)

		set message $payload(message)
		set name [Participant::name_for_chan $chan]

		set jsonmessage [jsonrpc'message "received-message" [list \
							name [j' $name] \
							message [j' $message] \
						]]

		Messagebus::notify "chat" $jsonmessage
	}

}
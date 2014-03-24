struct incomingmsg {
	message val
}

struct messagenotification {
	name val
	message val
}

namespace eval Action::message {

	proc on-message {chan data} {

		# cast to 'message'
		set data [cast $data message]

		# get payload, cast to 'incomingmsg'
		set incoming [cast [message.payload data] incomingmsg]

		# get name
		set name [Participant::name_for_chan $chan]

		# get message from incoming message
		set message [incomingmsg.message incoming]

		# generate outgoing message
		set outgoingmessage [create messagenotification {
				name $name
				message $message
			}]

		# send.
		set outgoing [jsonrpc'message "received-message" $outgoingmessage]

		Messagebus::notify "chat" $outgoing

		# nothing to return
		return 
	}

}
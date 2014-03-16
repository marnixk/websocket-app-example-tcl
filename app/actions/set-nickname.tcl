#
#   When someone enters their nickname, they enter the map
#
namespace eval Action::set-nickname {

	#
	#	When the message arrives, unwrap it, set the nickname
	#	signal the application to load a different page and notify
	#	the others on the 'chat' topic that someone has joined.
	#
	proc on-message {chan data} {
		array set arr_data $data
		array set payload $arr_data(payload)
		set name $payload(name)

		Participant::joined $chan $name

		# change page
		# app'load-page $chan "chat"

		# show others a new user joined.
		notify-others $chan $name

		# should listen to chat events
		Messagebus::subscribe $chan "chat"

		# return a message 
		array set msg [jsonrpc'respond-to $data]
		set msg(help) [j' "this is just some string"]
		return [array get msg]
	}


	#
	#   Notify others on the 'chat' topci of the arrival of '$name'
	#
	proc notify-others {chan name} {
		set output(name) $name

		Messagebus::notify "chat" [jsonrpc'message "joined" [list name [j' $name]]]
	}
}

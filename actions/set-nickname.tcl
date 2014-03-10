#
#   When someone enters their nickname, they enter the map
#
namespace eval Action::set-nickname {

	proc on-message {chan data} {
		array set arr_data $data
		array set payload $arr_data(payload)
		set name $payload(name)

		Participant::joined $chan $name

		redirect-to-new-page $chan
		notify-others $chan $name
	}

	#
	#	Make 'm go to the chat area
	#
	proc redirect-to-new-page {chan} {
		Websocket::send-message $chan [jsonrpc'message "load-page" [list page [j' "chat"]]]
	}

	#
	#   Notify others of your arrival
	#
	proc notify-others {chan name} {
		set output(name) $name
		Websocket::broadcast $chan [jsonrpc'message "joined" [list name [j' $name]]]
	}
}

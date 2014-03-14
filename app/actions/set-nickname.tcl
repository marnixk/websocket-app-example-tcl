#
#   When someone enters their nickname, they enter the map
#
namespace eval Action::set-nickname {

	proc on-message {chan data} {
		array set arr_data $data
		array set payload $arr_data(payload)
		set name $payload(name)

		Participant::joined $chan $name

		app'load-page $chan "chat"
		notify-others $chan $name
	}


	#
	#   Notify others of your arrival
	#
	proc notify-others {chan name} {
		set output(name) $name

		Messagebus::subscribe $chan "chat"
		Messagebus::notify "chat" [jsonrpc'message "joined" [list name [j' $name]]]
	}
}

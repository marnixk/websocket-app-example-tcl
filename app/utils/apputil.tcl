proc app'load-page {chan page} {
	Websocket::send-message $chan [jsonrpc'message "load-page" [list page [j' $page]]]
}

proc app'start {} {
	global config
	Websocket::start $config(wsport)
}
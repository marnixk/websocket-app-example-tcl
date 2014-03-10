namespace eval Participant {

	variable chan_nick_map
	variable members
	variable chat

	#
	#   Someone joined the chat
	#
	proc joined {chan name} {
		variable members 
		variable chan_nick_map

		lappend members $name
		set chan_nick_map($chan) $name
	}

	#
	#   Determine whether person is a member of the chat.
	#
	proc name_for_chan {chan} {
		variable chan_nick_map
		return [lindex [array get chan_nick_map $chan] 1]
	}

	#
	#   Publish something someone said.
	#
	proc spoke {chan name message} {
		variable chat
		lappend chat [list name message]
	}

	#
	#	Left the channel, do bookkeeping.
	#
	proc left { chan } {
		variable members 
		variable chan_nick_map

		# get nick name for this channel
		set name $chan_nick_map($chan)

		# find member name index
		set idx [lsearch $members $name]

		# remove from list
		set members [lreplace $members $idx $idx]

		array unset $chan_nick_map($chan)
	}

}
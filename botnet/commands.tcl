bind pub - !relay pub:relay
proc pub:relay {nick host hand chan text} {
	set rel [lrange $text 0 end]
	set adminchan "#AdminChannel"
	set network "Network Sending Message"
		if {$chan == $adminchan} {
		putallbots "RELAY :$network/-$nick :$rel"
	} else {
		puthelp "PRIVMSG #AdminChannel :Nope"
	}
}

bind pub - !announce pub:grelay
proc pub:grelay {nick host hand chan text} {
	set grel [lrange $text 0 end]
	set adminchan "#AdminChannel"
		if {$chan == $adminchan} {
		putallbots "GRELAY Announcement ($nick) $grel"
		putserv "PRIVMSG #ChannelToBroadcastTo :Announcement ($nick) $grel"
	} else {
		puthelp "PRIVMSG #AdminChannel :Nope"
	}
}

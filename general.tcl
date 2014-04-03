bind pub - !voice pub:voice
proc pub:voice {nick host hand chan text} {
	set p2v [lrange $text 0 end]
		if {[isop $nick $chan] == 1} {
			putserv "mode $chan +v $p2v"
		} else {
			return 1
	}
}
bind pub - !kick pub:kick
proc pub:kick {nick host hand chan text} {
	set p2k [lindex $text 0]
	set r4k [lrange $text 1 end]
		if {[isop $nick $chan] == 1} {
			putkick $chan $p2k "($nick ($r4k))"
		} else {
			return 1
	}
}
bind pub - !rkick pub:rkick
proc pub:rkick {nick host hand chan text} {
	set p2k [lindex $text 0]
	set r4k [lrange $text 1 end]
	set adminchan "#SpadeTest"
		if {[matchattr $hand o $chan] == 1} {
			if {$chan == $adminchan} {
			putkick #ChasedSpade $p2k "($nick ($r4k))"
		} else {
			putnow "PRIVMSG #SpadeTest :RKick denied."
	}
}
}
bind pub - !gtopic pub:gtopic
proc pub:gtopic {nick host hand chan text} {
	set gt [lrange $text 0 end]
	set adminchan "#SpadeTest"		
		if {[matchattr $hand o $chan] == 1} {
			if {$chan == $adminchan} {
			putallbots "TOPIC : $gt"
		} else {
			putnow "PRIVMSG #SpadeTest :Nope"
	}
}
}
bind bot - TOPIC bot:TOPIC
proc bot:TOPIC {from-bot command text} {
	set gt [lrange $text 0 end]
		putnow "TOPIC #ChasedSpade $gt"
}
bind bot - RELAY bot:RELAY
proc bot:RELAY {from-bot command text} {
	set rel [lrange $text 0 end]
		puthelp "PRIVMSG #ChasedSpade $rel"
}
bind bot - GRELAY bot:GRELAY
proc bot:GRELAY {from-bot command text} {
	set grel [lrange $text 0 end]
		puthelp "PRIVMSG #ChasedSpade :$grel"
}
bind pub - !relay pub:relay
proc pub:relay {nick host hand chan text} {
	set rel [lrange $text 0 end]
	set adminchan "#SpadeTest"
		if {$chan == $adminchan} {
		global server
		putallbots "RELAY :DumbIRC/-$nick :$rel"
	} else {
		puthelp "PRIVMSG #SpadeTest :Nope"
	}
}
bind pub - !announce pub:grelay
proc pub:grelay {nick host hand chan text} {
	set grel [lrange $text 0 end]
	set adminchan "#SpadeTest"
		if {$chan == $adminchan} {
		putallbots "GRELAY Announcement ($nick) $grel"
		putserv "PRIVMSG #ChasedSpade :Announcement ($nick) $grel"
	} else {
		puthelp "PRIVMSG #SpadeTest :Nope"
	}
}
bind pub - !devoice pub:devoice
proc pub:devoice {nick host hand chan text} {
	set p2uv [lindex $text 0]
	set r4uv [lrange $text 1 end]
		if {[isop $nick $chan] == 1} {
			putserv "mode $chan -v $p2uv"
		} else {
			puthelp "NOTICE $nick :You must be a channel operator in $chan to use this command."
	}
}
bind pub - !voiceme pub:voiceme
proc pub:voiceme {nick host hand chan text} {
	if {[matchattr $hand v $chan] == 1} {
		putserv "mode $chan +v $nick"
	} else {
		puthelp "NOTICE $nick :You do not have the appropriate flags set for ($nick)."
		puthelp "PRIVMSG #SpadeTest :$nick tried to use !voiceme but doesn't not have the appropriate flags."
	}
}
bind pub - !op pub:op
proc pub:op {nick host hand chan text} {
	set p2o [lrange $text 0 end]
	if {[isop $nick $chan] == 1} {
		putserv "mode $chan +o $p2o"
	} else {
		putserv "NOTICE $nick :You must be a channel operator in $chan to use this command."
	}
}
bind pub - !opme pub:opme
proc pub:opme {nick host hand chan text} {
	if {[matchattr $hand o $chan] == 1} {
		putserv "mode $chan +o $nick"
	} else {
		putserv "NOTICE $nick :You are not a designated channel operator in $chan."
			putserv "PRIVMSG ChasedSpade :($nick) attempted to use the !opme command but was denied."
	}
}
bind pub - !deop pub:deop
proc pub:deop {nick host hand chan text} {
	set p2do [lindex $text 0]
	set r4do [lrange $text 1 end]
	if {[isop $nick $chan] == 1] {
		putserv "mode $chan -o $p2do"
			putserv "PRIVMSG $chan :$p2do was deoped by $nick. Reason: $r4do."
	} else {
		putserv "NOTICE $nick :You must be a channel operator in $chan to use this command."
		}
	}
}
bind pub - !join pub:join
proc pub:join {nick host hand chan text} {   
    set c2j [lindex $text 0]
        if {[matchattr $hand m $chan] == 1 || [botonchan $c2j] == 0} {
			putserv "PRIVMSG #SpadeTest :Joined $c2j by request of $nick."
			channel add $c2j
   		 } else {
        		putserv "PRIVMSG $nick :Denied."
        }
    }


bind pub - !part pub:part
proc pub:part {nick host hand chan text} {
    set c2p [lindex $text 0]
        if {[matchattr $hand m $chan] == 1 || [botonchan $c2p] == 1} {
        channel remove $c2p
	putserv "PRIVMSG #SpadeTest :Parted $c2p by request of $nick."
    } else {
        putserv "PRIVMSG $nick :Denied"
        }
    }
bind pub - !rehash pub:rehash
proc pub:rehash {nick host hand chan text} {
        if {[matchattr $hand m] == 1} {
        rehash
            puthelp "PRIVMSG #SpadeTest :Rehashed by order of $nick."
    } else {
        	return 0
        }
    }
bind pub - !chanset pub:chanset
proc pub:chanset {nick host hand chan text} {
	set c2c [lindex $text 0]
	set s2c [lrange $text 1 end]
	if {[matchattr $hand m $c2c] == 1} {
	puthelp "PRIVMSG #SpadeTest :Changing settings $s2c on $c2c by order of $nick."
	channel set $c2c $s2c
	} else {
		puthelp "NOTICE $nick :You aren't authorized to use this command."
			puthelp "PRIVMSG #SpadeTest :$nick attempted to use the !chanset command but was denied."
		}
	}
bind pub - !ban pub:ban
proc pub:ban {nick host hand chan text} {
    set o2b [lindex $text 0]
    set t4b [lindex $text 1]
    set r4b [lrange $text 2 end]
    if {[isop $nick $chan] == 1} {
    newchanban $chan $o2b $nick $r4b $t4b none
    } else {
        putserv "NOTICE $nick :You must be oped in $chan to use this command."
        }
    }
bind pub - !quiet pub:quiet2
proc pub:quiet2 {nick host hand chan text} {
	set p2q [lindex $text 0]
		if {[isop $p2q $chan] == 1} {
			putserv "MODE $chan :-o $p2q"
			if {[isvoice $p2q $chan] == 1}
				putserv "MODE $chan :-v $p2q"
				putserv "MODE $chan :+q $p2q!*@*"
		

     		} elseif {[isop $p2q $chan] == 0} {
			if {[isvoice $p2q $chan] == 1}
				putserv "MODE $chan :-v $p2q"
		} elseif {[isop $p2q $chan] && [isvoice $p2q $chan] == 0}
			putserv "MODE $chan :+q $p2q!*@*"
	}
 

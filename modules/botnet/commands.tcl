# SBScripts - A management/botnet script system to help Channel Owners/Admins
# Copyright (C) 2014 Chris Tyrrel

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

bind pub - !relay pub:relay
bind pub - !announce pub:announce
bind pub - !gban pub:gban

proc pub:relay {nick host hand chan text} {
global AdminChan network
	set rel [lrange $text 0 end]
		if {$chan == $AdminChan} {
		putallbots "RELAY :$network/$nick $rel"
	} else {
		putnow "PRIVMSG #AdminChannel :Nope"
	}
}

proc pub:announce {nick host hand chan text} {
global AdminChan MainChan
	set grel [lrange $text 0 end]
		if {$chan == $AdminChan} {
		putallbots "GRELAY Announcement ($nick) $grel"
		putnow "PRIVMSG $MainChan :Announcement ($nick) $grel"
	} else {
		putnow "PRIVMSG #AdminChannel :Nope"
	}
}

proc pub:gban {nick host hand chan text} {
global AdminChan MainChan
	set s2b [lindex $text 0]
	set t4b [lindex $text 1]
	set r4b [lrange $text 2 end]
		if {$chan == $AdminChan && [isop $nick $chan]} {
		newchanban $MainChan $s2b $nick $r4b $t4b
		putallbots "GBAN $MainChan $s2b $nick $t4b $r4b"
		putnow "PRIVMSG $AdminChan :The ban on $s2b for reason $r4b, which is set to expire in $r4b has been set."
		putnow "PRIVMSG $AdminChan :This ban will be sent to the other bot(s) shortly."
		} else {
		return 1
	}
}
	
	

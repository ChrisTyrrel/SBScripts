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

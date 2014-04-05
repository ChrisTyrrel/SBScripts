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

# Join the channel specified.

bind pub - !join pub:join
proc pub:join {nick host hand chan text} {   
    
    # We will take the first word after !join and use it as the channel to join.
    set c2j [lindex $text 0]
    	
    	# We must check if the handle has the "m" (Admin) flag. We also must not be on the requested channel.
        if {[matchattr $hand m $chan] == 1 || [botonchan $c2j] == 0} {
        	
        		# We shall inform the admin channel.
			putserv "PRIVMSG #AdminChannel :Joined $c2j by request of $nick."
		
			# We add it to our internal list, then join specified channel.
			channel add $c2j
   		 } else {
   		 	
   		 	# We will PM the user if they are not an admin ("M" flag), or we are already on the specified channek.
        		putserv "PRIVMSG $nick :Denied."
        }
    }

# Part the channel specified.
bind pub - !part pub:part
proc pub:part {nick host hand chan text} {
    
    # We will take the first word after !part and use it as the channel to part.
    set c2p [lindex $text 0]
    	
    	# We must check if the handle has the "m" (Admin) flag. We also must not be on the requested channel. 
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

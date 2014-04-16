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

# The definition of an upgrade: Take old bugs out, put new ones in.




#Channel Commands
bind pub - !join pub:join
bind pub - !part pub:part
bind pub - !chanset pub:chanset

#Bot Management Commands
bind pub - !shutdown pub:shutdown
bind pub - !raw pub:raw
bind pub - !ns pub:ns
bind pub - !rehash pub:rehash
bind pub - !version pub:version



# Join the channel specified.
proc pub:join {nick host hand chan text} {
global AdminChan

	set c2j [lindex $text 0]
		if {$chan == $AdminChan && [isop $nick $chan] == 1} {
			channel add $c2j
			puthelp "PRIVMSG $AdminChan :Joined $c2j by order of $nick."
		} else {
			return 1
		}
	}


# Part the channel specified.

proc pub:part {nick host hand chan text} {
global AdminChan
    
    # We will take the first word after !part and use it as the channel to part.
    set c2p [lindex $text 0]
    	
    	# We must check if the handle has the "m" (Admin) flag. We also must not be on the requested channel. 
        if {$chan == $AdminChan && [isop $nick $chan] && [botonchan $c2p]} {
		
		# We remove it from our internal list, then part the specified channel.
        	channel remove $c2p

		# Again, we inform the admin channel.
		putserv "PRIVMSG $AdminChan :Parted $c2p by request of $nick."
    } else {

	# We will PM the user if they are not an admin ("M" flag), or we are already on the specified channek.
       	return 1
        }
    }

# Reload the bot's scripts.

proc pub:rehash {nick host hand chan text} {
global AdminChan

	# First, we check if the handle has the "m" (Admin) flag.
        if {$chan == $AdminChan && [isop $nick $AdminChan]} {

		# We then rehash our scripts.
        	rehash
		
		# Now, we inform the admin channel.
            	puthelp "PRIVMSG $AdminChan :Rehashed by order of $nick."
    } else {

		# We will say the script has been completed despite the user not being an admin ("M" flag).
        	return 1
        }
    }

proc pub:chanset {nick host hand chan text} {
global AdminChan

	set c2c [lindex $text 0]
	set s2c [lrange $text 1 end]
	if {[matchattr $hand m $c2c] == 1} {
	puthelp "PRIVMSG $AdminChan :Changing settings $s2c on $c2c by order of $nick."
	channel set $c2c $s2c
	} else {
		puthelp "NOTICE $nick :You aren't authorized to use this command."
			puthelp "PRIVMSG #SpadeTest :$nick attempted to use the !chanset command but was denied."
		}
	}

proc pub:shutdown {nick host hand chan text} {
global AdminChan
	if {$chan == $AdminChan && [isop $nick $AdminChan] == 1} {
		puthelp "PRIVMSG $AdminChan :Shutting down by order of $nick."
		die
	}
}
proc pub:raw {nick host hand chan text} {
global AdminChan
set raw [lrange $text 0 end]
	if {$chan == $AdminChan && [isop $nick $chan]} {
		putserv "$raw"
	} else {
		return 1
}
}

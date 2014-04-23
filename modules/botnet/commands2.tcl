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

bind pub m !g pub:global
pub:global {nick host hand chan text} {
Global AdminChan Owner MainChan
	set cmd [lindex $text 0]
		if {$cmd == "rehash"} {
			putnow "PRIVMSG $AdminChan :Global rehash initiated by $nick."
			putallbots "GREHASH $nick"
			rehash
			putnow "PRIVMSG $AdminChan :Local bot has been rehashed."
			
		} elseif {$cmd == "announce"} {
			set announcemsg [lrange $text 1 end]
				putnow "PRIVMSG $AdminChan :$nick is globally announcing ($announcemsg)"
				putnow "PRIVMSG $MainChan :\002Announcement\002 from \002$nick\002 : \026$announcemsg\026"
				putallbots "GANNOUNCE $nick $announcemsg"
		
		} elseif {$cmd == "shutdown"} {
				putnow "PRIVMSG $AdminChan :Global shutdown initiated by $nick."
				putnow "PRIVMSG $AdminChan :Sending shutdown command to other bot(s) on botnet."
				putallbots "GSHUTDOWN $nick"
				putnow "PRIVMSG $AdminChan :Shutting down."
				die "Shutdown by $nick."
		
		} elseif {$cmd == "restart"} {
			putnow "PRIVMSG $AdminChan :Global restart initiated by $nick."
			putnow "PRIVMSG $AdminChan :Sending shutdown command to other bot(s) on botnet."
			putallbots "GRESTART $nick"
			putnow "PRIVMSG $AdminChan :Restarting."
			restart
		
		} else {
			putnow "PRIVMSG $AdminChan :The command ($cmd) doesn't exist."
			}
		}
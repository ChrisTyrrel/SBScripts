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
proc pub:global {nick host hand chan text} {
global AdminChan Owner MainChan
	set cmd [string tolower [lindex $text 0]]
		if {$cmd == "rehash"} {
			putnow "PRIVMSG $AdminChan :Global rehash initiated by $nick."
			putallbots "GLOBAL REHASH $nick"
			rehash
			putnow "PRIVMSG $AdminChan :Local bot has been rehashed."
			
		} elseif {$cmd == "announce"} {
			set announcemsg [lrange $text 1 end]
				putnow "PRIVMSG $AdminChan :$nick is globally announcing ($announcemsg)"
				putnow "PRIVMSG $MainChan :\002Announcement\002 from \002$nick\002 : $announcemsg"
				putallbots "GLOBAL ANNOUNCE $nick $announcemsg"
				putnow "PRIVMSG $AdminChan :Announcement has been made locally."
		
		} elseif {$cmd == "shutdown"} {
				putnow "PRIVMSG $AdminChan :Global shutdown initiated by $nick."
				putnow "PRIVMSG $AdminChan :Sending shutdown command to other bot(s) on botnet."
				putallbots "GLOBAL SHUTDOWN $nick"
				putnow "PRIVMSG $AdminChan :Shutting down."
				die "Shutdown by $nick."
		
		} elseif {$cmd == "restart"} {
			putnow "PRIVMSG $AdminChan :Global restart initiated by $nick."
			putnow "PRIVMSG $AdminChan :Sending shutdown command to other bot(s) on botnet."
			putallbots "GLOBAL RESTART $nick"
			putnow "PRIVMSG $AdminChan :Restarting."
			restart
			
		} elseif {$cmd == "topic"} {
			set topic [lrange $text 1 end]
				putnow "PRIVMSG $AdminChan :Global topic change on $MainChan initiated by $nick."
				putnow "PRIVMSG $AdminChan :New topic ($topic) has been sent to other bot(s) on botnet."
				putallbots "GLOBAL TOPIC $nick $topic"
				putnow "TOPIC $MainChan :$topic"
				putnow "PRIVMSG $AdminChan :Topic has been applied locally."
				
		} elseif {$cmd == "ban"} {
			set o2b [lindex $text 0]
			set t2b [lindex $text 1]
			set r4b [lrange $text 2 end]
				putnow "PRIVMSG $AdminChan :Global ban on $o2b on $MainChan has been activated by $nick."
				putnow "PRIVMSG $AdminChan :New ban ($o2b) has been sent to other bot(s) on botnet."
				putallbots "GLOBAL BAN $nick $o2b $t2b $r4b"
				newchanban $MainChan $o2b $nick $r4b $t2b
				putnow "PRIVMSG $AdminChan :Ban has been applied locally."
		
		} elseif {$cmd == "version"} {
				putnow "PRIVMSG $AdminChan :Global version check has been initiated by $nick."
				putallbots "GLOBAL VERSION $nick"
		
		} else {
			putnow "PRIVMSG $AdminChan :The command ($cmd) doesn't exist."
			}
		}

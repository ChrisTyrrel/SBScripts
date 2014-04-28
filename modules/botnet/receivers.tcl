    # SBScripts - A management/botnet script system to help Channel Owners/Admins
    # Copyright (C) 2014  Chris Tyrrel

    # This program is free software: you can redistribute it and/or modify
    # it under the terms of the GNU General Public License as published by
    # the Free Software Foundation, either version 3 of the License, or
    # (at your option) any later version.

    # This program is distributed in the hope that it will be useful,
    # but WITHOUT ANY WARRANTY; without even the implied warranty of
    # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    # GNU General Public License for more details.

    # You should have received a copy of the GNU General Public License
    # along with this program.  If not, see <http://www.gnu.org/licenses/>.

bind bot - GLOBAL bot:GLOBAL

proc bot:GLOBAL {from-bot command text} {
global AdminChan MainChan SBScriptsVersion network
	set command [lindex $text 0]
	set nick [lindex $text 1]
		if {$command == "REHASH"} {
			putnow "PRIVMSG $AdminChan :Global rehash initiated by $nick."
				rehash
			putnow "PRIVMSG $AdminChan :Local bot has been rehashed."
			
		} elseif {$command == "ANNOUNCE"} {
			set announcemsg [lrange $text 2 end]
				putnow "PRIVMSG $MainChan :\002Announcement\002 from \002$nick\002 : $announcemsg"
			
		} elseif {$command == "SHUTDOWN"} {
			putnow "PRIVMSG $AdminChan :Global shutdown initiated by $nick."
			putnow "PRIVMSG $AdminChan :Shutting down."
			die "Shutdown by $nick"
		
		} elseif {$command == "RESTART"} {
			putnow "PRIVMSG $AdminChan :Global restart initiated by $nick."
			putnow "PRIVMSG $AdminChan :Restarting."
			restart
		
		} elseif {$command == "TOPIC"} {
			set topic [lrange $text 2 end]
				putnow "TOPIC $MainChan :$topic"
				
		} elseif {$command == "ban"} {
			set o2b [lindex $text 2]
			set t2b [lindex $text 3]
			set r4b [lrange $text 4 end]
				putnow "PRIVMSG $AdminChan :Global ban on $o2b on $MainChan has been activated by $nick."
				newchanban $MainChan $nick $o2b $r4b $t2b
		
		} elseif {$command == "VERSION"} {
			putbot $from-bot "GLOBAL VERSIONR $network $SBScriptsVersion"
			
		} elseif {$command == "VERSIONR"} {
			set network [lindex $text 2]
			set version [lindex $text 3]
				putnow "PRIVMSG $AdminChan :$network: $version"
		} elseif {$command == "PING"} {
			putbot $from-bot "GLOBAL PONG $network"
		
		} elseif {$command == "PONG"} {
			set network [lindex $text 2]
			putnow "PRIVMSG $AdminChan :$network: PONG"
			
		} else {
			return 1
		}
}

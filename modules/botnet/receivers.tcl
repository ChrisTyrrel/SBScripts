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

bind bot - TOPIC bot:TOPIC
bind bot - RELAY bot:RELAY
bind bot - GRELAY bot:GRELAY
bind bot - GBAN bot:GBAN


proc bot:TOPIC {from-bot command text} {
global AdminChan MainChan
	set gt [lrange $text 0 end]
		putserv "TOPIC #ChannelToChangeTopic $gt"
}

proc bot:RELAY {from-bot command text} {
global MainChan
	set rel [lrange $text 0 end]
		puthelp "PRIVMSG $MainChan $rel"
}

proc bot:GRELAY {from-bot command text} {
global MainChan
	set grel [lrange $text 0 end]
		puthelp "PRIVMSG $MainChan :$grel"
}
proc bot:GBAN {from-bot command text} {
global AdminChan
	set c2b [lindex $text 0]
	set s2b [lindex $text 1]
	set pwb [lindex $text 2]
	set t4b [lindex $text 3]
	set r4b [lrange $text 4 end]
		puthelp "PRIVMSG $AdminChan :Recieved ban on $s2b for reason $r4b, which is set to expire in $t4b. This ban was set by $pwb."
		newchanban $c2b $s2b $pwb $r4b $t4b
		puthelp "PRIVMSG $AdminChan :This ban has been set on $c2b."
}

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
proc bot:TOPIC {from-bot command text} {
	set gt [lrange $text 0 end]
		putnow "TOPIC #ChannelToChangeTopic $gt"
}

bind bot - RELAY bot:RELAY
proc bot:RELAY {from-bot command text} {
	set rel [lrange $text 0 end]
		puthelp "PRIVMSG #ChannelToRelayMessagesToo $rel"
}

bind bot - GRELAY bot:GRELAY
proc bot:GRELAY {from-bot command text} {
	set grel [lrange $text 0 end]
		puthelp "PRIVMSG #ChannelToRelayMessagesToo :$grel"
}


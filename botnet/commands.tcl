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
proc pub:relay {nick host hand chan text} {
	set rel [lrange $text 0 end]
	set adminchan "#AdminChannel"
	set network "Network Sending Message"
		if {$chan == $adminchan} {
		putallbots "RELAY :$network/-$nick :$rel"
	} else {
		puthelp "PRIVMSG #AdminChannel :Nope"
	}
}

bind pub - !announce pub:grelay
proc pub:grelay {nick host hand chan text} {
	set grel [lrange $text 0 end]
	set adminchan "#AdminChannel"
		if {$chan == $adminchan} {
		putallbots "GRELAY Announcement ($nick) $grel"
		putserv "PRIVMSG #ChannelToBroadcastTo :Announcement ($nick) $grel"
	} else {
		puthelp "PRIVMSG #AdminChannel :Nope"
	}
}

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

bind pub - !voice pub:voice
proc pub:voice {nick host hand chan text} {
	set p2v [lrange $text 0 end]
		if {[isop $nick $chan] == 1} {
			putserv "mode $chan +v $p2v"
		} else {
			return 1
	}
}

bind pub - !kick pub:kick
proc pub:kick {nick host hand chan text} {
	set p2k [lindex $text 0]
	set r4k [lrange $text 1 end]
		if {[isop $nick $chan] == 1} {
			putkick $chan $p2k "($nick ($r4k))"
		} else {
			return 1
	}
}

bind pub - !devoice pub:devoice
proc pub:devoice {nick host hand chan text} {
	set p2uv [lindex $text 0]
	set r4uv [lrange $text 1 end]
		if {[isop $nick $chan] == 1} {
			putserv "mode $chan -v $p2uv"
		} else {
			puthelp "NOTICE $nick :You must be a channel operator in $chan to use this command."
	}
}

bind pub - !voiceme pub:voiceme
proc pub:voiceme {nick host hand chan text} {
	if {[matchattr $hand v $chan] == 1} {
		putserv "mode $chan +v $nick"
	} else {
		puthelp "NOTICE $nick :You do not have the appropriate flags set for ($nick)."
		puthelp "PRIVMSG #SpadeTest :$nick tried to use !voiceme but doesn't not have the appropriate flags."
	}
}

bind pub - !op pub:op
proc pub:op {nick host hand chan text} {
	set p2o [lrange $text 0 end]
	if {[isop $nick $chan] == 1} {
		putserv "mode $chan +o $p2o"
	} else {
		putserv "NOTICE $nick :You must be a channel operator in $chan to use this command."
	}
}

bind pub - !opme pub:opme
proc pub:opme {nick host hand chan text} {
	if {[matchattr $hand o $chan] == 1} {
		putserv "mode $chan +o $nick"
	} else {
		putserv "NOTICE $nick :You are not a designated channel operator in $chan."
			putserv "PRIVMSG ChasedSpade :($nick) attempted to use the !opme command but was denied."
	}
}

bind pub - !deop pub:deop
proc pub:deop {nick host hand chan text} {
	set p2do [lindex $text 0]
	set r4do [lrange $text 1 end]
	if {[isop $nick $chan] == 1] {
		putserv "mode $chan -o $p2do"
			putserv "PRIVMSG $chan :$p2do was deoped by $nick. Reason: $r4do."
	} else {
		putserv "NOTICE $nick :You must be a channel operator in $chan to use this command."
		}
	}
}

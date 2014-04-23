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
Global AdminChan MainChan
	set command [lindex $text 1]
		if {$command == "rehash} {
			

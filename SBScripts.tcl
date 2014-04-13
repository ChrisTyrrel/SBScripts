# TO INSTALL! ONLY LIST THIS FILE IN YOUR EGGDROP CONFIGURATION!

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

set SBScriptsRoot "scripts/SBScripts"
set SBScriptsModules "$SBScriptsRoot/modules"
set SBScriptsLocal "$SBScriptsRoot/local"

source "$SBScriptsRoot/VERSION"
	putlog "SBScripts $SBScriptsVersion has been enabled."
source "$SBScriptsLocal/settings.tcl"
	putlog "SBScripts settings have been loaded from $SBScriptsLocal."
source "$SBScriptsModules/administration/commands.tcl"
	putlog "SBScripts administration commands have been loaded."
source "$SBScriptsModules/botnet/commands.tcl"
	putlog "SBScripts botnet commands have been loaded."
source "$SBScriptsModules/botnet/recievers.tcl"
	putlog "SBScripts botnet recievers have been loaded."
source "$SBScriptsModules/channel/commands.tcl"
	putlog "SBScripts channel commands have been loaded."
source "$SBScriptsRoot/VERSION"
	putlog "\002SBScripts $SBScriptsVersion has been enabled.\002"


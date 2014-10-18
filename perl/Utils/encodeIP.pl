#!/usr/bin/perl -w

#########################################################################
#  Copyright (c) 2013 StepHack.Com, All rights reserved.
#
#  This software is open source, licensed under the GNU General Public
#  License, version 2.
#  Basically, this means that you're allowed to modify and distribute
#  this software. However, if you distribute modified versions, you MUST
#  also distribute the source code.
#  See http://www.gnu.org/licenses/gpl.html for the full license.
#########################################################################

sub encodeIP {  
    return pack("C*", split(/\./, shift));  
}

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

##
# max($a, $b)
#
# Returns the greater of $a or $b.
sub max {
    my ($a, $b) = @_;

    return $a > $b ? $a : $b;
}
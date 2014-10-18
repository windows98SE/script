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
# timeConvert(seconds)
# seconds: number of seconds.
# Returns: a human-readable version of $seconds.
#
# Converts $seconds into a string in the form of "x hours y minutes z seconds".
sub timeConvert {
    my $time = shift;
    my $hours = int($time / 3600);
    my $time = $time % 3600;
    my $minutes = int($time / 60);
    my $time = $time % 60;
    my $seconds = $time;
    my $gathered = '';

    $gathered = "$hours hours " if ($hours);
    $gathered .= "$minutes minutes " if ($minutes);
    $gathered .= "$seconds seconds" if ($seconds);
    $gathered =~ s/ $//;
    $gathered = '0 seconds' if ($gathered eq '');
    return $gathered;
}

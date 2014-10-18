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

sub getFormattedDate {
    my $thetime = shift;
    my $r_date = shift;
    my @localtime = localtime $thetime;
    my $themonth = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)[$localtime[4]];
    $localtime[2] = "0" . $localtime[2] if ($localtime[2] < 10);
    $localtime[1] = "0" . $localtime[1] if ($localtime[1] < 10);
    $localtime[0] = "0" . $localtime[0] if ($localtime[0] < 10);
    $$r_date = "$themonth $localtime[3] $localtime[2]:$localtime[1]:$localtime[0] " . ($localtime[5] + 1900);
    return $$r_date;
}

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

sub makeIP {
    my $ret;
    my $raw = $_[0];
    for (my $i = 0; $i < 4; $i++) {
        $ret .= hex(getHex(substr($raw, $i, 1)));
        if ($i + 1 < 4) {
            $ret .= ".";
        }
    }
    return $ret;
}

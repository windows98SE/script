#!/usr/bin/perl -w

die "Usage Example: $0 aa:bb:cc:dd:ee:ff\n" unless ($ARGV[0]);

use Net::MAC::Vendor;
Net::MAC::Vendor::load_cache( 'oui.txt' );

print Net::MAC::Vendor::lookup($ARGV[0])->[0]."\n";

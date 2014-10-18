#!/usr/bin/perl -w
# range2cidr.pl
use Net::CIDR;
use Net::CIDR ':all';

die "Usage Example: $0 192.168.0.0-192.168.255.255\n" unless (@ARGV != 0);
print join("\n", Net::CIDR::range2cidr(join '', @ARGV)) . "\n";
#!/usr/bin/perl -w
# domain2cidr.pl
use Socket;
use Net::CIDR;

die "Usage Example: $0 stephack.com\n" unless ($ARGV[0]);
my $ip = gethostbyname($ARGV[0])?inet_ntoa((gethostbyname($ARGV[0]))[4]):$ARGV[0];
my $whois = join('',`whois -A $ip`);
my ($range) = $whois =~ /inetnum:(.+)?/;
$range =~ s/\s+//ig;
print join("\n", Net::CIDR::range2cidr($range))."\n";
#!/usr/bin/perl -w
use Socket;

my $ipaddr = gethostbyname('192.168.1.88'); # target ip address
my $payload = magic_packet('74:D0:2B:2A:82:B4'); # target mac address
my $pack_remote_addr = pack_sockaddr_in(9, $ipaddr);

socket(S, AF_INET, SOCK_DGRAM, 17);
setsockopt(S, SOL_SOCKET, SO_BROADCAST, 1);
send(S, $payload, 0, $pack_remote_addr);

sub magic_packet {
  return chr(0xFF) x 6 .(join'',map{chr(hex($_))}split/:/,$_[0]) x 16;
}

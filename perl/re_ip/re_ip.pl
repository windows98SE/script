#!/usr/bin/perl -w
use Socket;
use LWP::UserAgent;

# global var/definitions
my $TIMEOUT = 15;
my $VERSION = '1.1';
my $UPDATE = '05/07/2012';

if(!checkHostByName($ARGV[0])){
  &usage;
  exit(1);
}

my $browser = LWP::UserAgent->new(
  agent => 'reverse ip tools v.'.$VERSION,
  timeout => $TIMEOUT
);
my $resp = $browser->get('http://reip.stephack.com/'.$ARGV[0]);

if($resp->status_line =~ /200/){
  my $content = $resp->content;
  while ($content =~ /'>(.+?)<\/a><br \/>/ig){
	print "$1\n";
  }
}else{
  die ("[!] can't connect to http://reip.stephack.com/ ".$resp->status_line."\n");
}

sub checkHostByName {
  my $host = $_[0] || return;
  $host =~ s/http(s)?\:\/\/|\/$//gi;
  if(gethostbyname($host)){
    return inet_ntoa((gethostbyname($host))[4]);
  }
}

sub usage {
  if($^O =~ /Win/){system("cls");}else{system("clear");}
  print qq {
=================================================================
░░░░░░░░░░░░▄▄░░░░░░░░░░░░░░ Copyright (c) 2011 by windows98SE
░░░░░░░░░░░█░░█░░░░░░░░░░░░░
░░░░░░░░░░░█░░█░░░░░░░░░░░░░ This software is open source,
░░░░░░░░░░█░░░█░░░░░░░░░░░░░ licensed under the GNU/GPL,v3.
░░░░░░░░░█░░░░█░░░░░░░░░░░░░
██████▄▄█░░░░░██████▄░░░░░░░ Basically,
▓▓▓▓▓▓█░░░░░░░░░░░░░░█░░░░░░ this means that you're allowed to modify and
▓▓▓▓▓▓█░░░░░░░░░░░░░░█░░░░░░ distribute this software.
▓▓▓▓▓▓█░░░░░░░░░░░░░░█░░░░░░ However, if you distribute modified versions,
▓▓▓▓▓▓█░░░░░░░░░░░░░░█░░░░░░ you MUST also distribute the source code.
▓▓▓▓▓▓█░░░░░░░░░░░░░░█░░░░░░
▓▓▓▓▓▓█████░░░░░░░░░██░░░░░░ See http://www.gnu.org/licenses/gpl.html
█████▀░░░░▀▀████████░░░░░░░░ for the full license.
=================================================================
$0 is reverse DNS lookup tool by http://reip.stephack.com/<IP|hostname>
it easy way to view websites hosted on a given IP address or hostnames

version: $VERSION
update: $UPDATE
=================================================================
Usage: $0 <IP|hostname>
=================================================================
};

}

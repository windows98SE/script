#!/usr/bin/perl
use IO::Socket;

my $target = (checkHostByName($ARGV[0]))?$ARGV[0]:&usage();
my $start_port = ($ARGV[1]>1)?$ARGV[1]:&usage();
my $end_port = ($ARGV[2]<=0xffff)?(($ARGV[2]>$start_port)?$ARGV[2]:$start_port):&usage();

foreach $port ($start_port .. $end_port){
    if(my $socket =IO::Socket::INET->new(PeerAddr=>$target, PeerPort=>$port, Proto=>'tcp', Timeout=>0.5)){
        print "[+] Port $port Opened\n";
    }else{
        print "[-] Port $port Closed\n";
    }
}

#validate target
sub checkHostByName {
    my $host = $_[0] || return;
    $host =~ s/http(s)?\:\/\/|\/$//gi;
    if(gethostbyname($host)){
        return inet_ntoa((gethostbyname($host))[4]);
    }
}

sub usage {
    if($^O =~ /Win/){system("cls");}else{system("clear");}
    my $file_name = (split m{/|\\} => $0) [-1];
    print "[+] usage\n$file_name <target(ip|domain)> <start port(1-65535)> <end port(1-65535)>\n";
    exit();
}

#!/usr/bin/perl
#
# mem_search.pl
# desc : for besic search some sting in memory
# 
# usage : mem_search.pl <program name*> <string>
# *can use regexp
#
# ex. mem_search.pl cmd.exe kernel32

use Win32::Console::ANSI;
use Win32::Process::Info;
use Win32::Process::Memory;

my $program = $ARGV[0];
my $search = $ARGV[1];

if(!$program || !$search){&usage;}

my $process = Win32::Process::Info->new();
my ($processID) = grep{defined $_->{Name} && $_->{Name} =~ m/$program/i} $process->GetProcInfo();

&p_not_found() if(!$processID->{ProcessId});
my $mem = Win32::Process::Memory->new(
  {
	pid => $processID->{ProcessId},
	name=> $processID->{Name},
	access => 'read/query',
  }
);
&h_not_found() if(!$mem->{hProcess});

my @results = $mem->search_string($search);
foreach my $address (@results){
  next if(!$address);  
  my $content = hexdump_highlight($mem, $address, length($search));
  print "\t\t===== ".highlight3(sprintf( "%08X", $address)).' - '. highlight3(sprintf( "%08X", $address+length($search)-1))." (len:".length($search).") =====\n";
  print $content."\n";
}

print "===== Infomation =====\n";
print "Process Name : ".highlight($processID->{Name})."\n";
print "Search : ".highlight($search)." (".scalar(@results)." Found)\n";
print "Process ID : ".$processID->{ProcessId}." (hProcess : ".$mem->{hProcess}.")\n" ;
print "Owner : ".$processID->{Owner}."\n" if ($processID->{Owner});
print "Caption : ".$processID->{Caption}."\n" if ($processID->{Caption});
print "Description : ".$processID->{Description}."\n" if ($processID->{Description});
print "=================\n";
undef $mem;

sub highlight {return "\e[1;34m".$_[0]."\e[0m";}
sub highlight2 {return "\e[1;30m".$_[0]."\e[0m";}
sub highlight3 {return "\e[1;31m".$_[0]."\e[0m";}
sub p_not_found {
  print "PROCESS NAME NOT FOUND\n";
  exit();
}
sub h_not_found {
  print "NOT FOUND hProcess\n";
  exit();
}
sub usage {
  print "# usage : mem_search.pl <program name*> <string>
# *can use regexp
#
# ex. mem_search.pl cmd.exe kernel32
";
  exit();
}


sub hexdump_highlight {
	my ($this, $from, $len) = @_;
	return "Err: length is too long!" if $len > 65536;

	# caculate address
	my $addr				= $from - ( $from % 16 );
	my $to					= $from + $len;
	my $addr_to				= ( $to % 16 ) ? ( $to + 16 - $to % 16 ) : $to;
	my $addr_start				= ( $addr % 16 ) ? $addr : $addr - 16; 
	my $addr_len				= ( $addr_to - $addr_start )+16;

	# read buf
	my $buf;
	$this->get_buf( $addr_start, $addr_len, $buf );
	
	# caculate hex string and show string
	my $buf_hex = uc( unpack( 'H*', $buf ) );
	$buf_hex =~ s/\G(..)/$1 /g;
	my $buf_show = $buf;
	$buf_show =~ s/[^a-z0-9\\|,.<>;:'\@[{\]}#`!"\$%^&*()_+=~?\/ -]/./gi;
	
	# output
	my $output = highlight2("-------- : 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F")."\n";
	for ( my $offset = 0 ; $addr_start < $to+16; $offset+=16, $addr_start+=16) {
	  my $hex = '';
	  my $content = '';
	  for(my $i=0;$i<16;$i++){
		if(($addr_start + $i) >= $from && ($addr_start + $i) < $to){
		  $hex .= highlight(sprintf( "%s ",substr($buf_hex,  ($offset+$i)*3, 2 )));
		  $content .= highlight(sprintf( "%s",substr($buf_show, $offset+$i, 1)));
		}else{
		  $hex .= sprintf( "%s ",substr($buf_hex,  ($offset+$i)*3, 2 ));
		  $content .= sprintf( "%s",substr($buf_show, $offset+$i, 1));
		}
	  }
	  $output .= highlight2(sprintf( "%08X : ", $addr_start)).$hex.' : '.$content."\n";
	}
	return $output;
}

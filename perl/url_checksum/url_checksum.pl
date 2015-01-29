#!/usr/bin/perl -w
use Digest::MD5::File;
print Digest::MD5->new->addurl($ARGV[0])->hexdigest if($ARGV[0]);
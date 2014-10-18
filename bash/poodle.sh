#!/bin/bash
#
#  Copyright (C) 2014 by Dan Varga
#  dvarga@redhat.com
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  (at your option) any later version.


host=$1
port=$2

if [ "$2" == "" ]
then
	port=443
fi

echo $2
echo $port

out="`echo x | timeout 5 openssl s_client -ssl3 -connect ${host}:${port} 2>/dev/null`"
ret=$?

if [ $ret -eq 0 ]
then
	echo "VULNERABLE"
	exit
elif [ $ret -eq 1 ]
then
	out=`echo $out | perl -pe 's|.*Cipher is (.*?) .*|$1|'`
	if [ "$out" == "0000" ] || [ "$out" == "(NONE)" ]
	then
		echo "ALLGOOD"
		exit
	fi
elif [ $ret -eq 124 ]
then
	echo "error: timeout connecting to host $host:$port"
	exit
fi
echo "error: Unable to connect to host $host:$port"


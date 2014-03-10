#!/usr/bin/gawk -f
# usage: you must have a (empty or not) git repository set up first, of course...
# if not, do something like
# git init
# git config user.name FoobarBazbot
# git config user.email #####@#####
# git remote add origin git@github.com:FoobarBazbot/pgmtogithub.git
#
# then the actual pgmtogithub:
# pgmramp -ellipse -maxval 9 7 7 |pnmtoplainpnm |pgmtogithub.awk enddate=2013-05-01 |sh
#
# finally...
# git push -u origin master
#
BEGIN {
  getline;
  if(!/P2/) {
    print "not a plain/ascii pgm file, try pnmtoplainpnm?" >"/dev/stder";
    exit -1
  }
  getline;
  width=$1;
  height=$2;
  if(width != 7) {
    print "pgm width !=7 >" >"/dev/stderr";
    if($2 == 7) print "try pamflip -xy" >"/dev/stderr";
    exit -1;
  }
  if(height > 50) {
    print "pgm height >50" >"/dev/stderr";
    exit -1;
  }
  getline;
  if($1 > 255) {
    print "pgm maxval >255 not supported" >"/dev/stderr";
    exit -1;
  }
  "date -d 12:00\\ sunday +%s\\ %z" |getline;
  time=$1-7*24*60*60
  tz=$2;
  close("date -d 12:00\\ sunday +%s\\ %z");
}
!timedone {
  if(enddate) {
    "date -d " enddate " +%s" |getline endtime;
    close("date -d " enddate "+%s");
    while(time>endtime) time-=7*24*60*60;
  }
  time-=(height)*7*24*60*60;
  timedone=1;
}
{
 print "#" $0;
  for(i=1;i<=NF;i++) {
    for(j=0;j<$i;j++) {
      print("GIT_AUTHOR_DATE='" time+j " " tz "' git commit --allow-empty --allow-empty-message -m ''");
    }
    time += 24*60*60;
  }
}

#!/bin/awk -f
{ for(a=1;a<=NF;a++) {
   print "field",a,"is",$a
  }
}

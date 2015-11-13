#!/usr/bin/env perl 
#===============================================================================
#
#         FILE:  test.pl
#
#        USAGE:  ./test.pl  
#
#  DESCRIPTION:  
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Dr. Scott A. Givan (sag), givans@missouri.edu
#      COMPANY:  University of Missouri, USA
#      VERSION:  1.0
#      CREATED:  10/29/15 15:13:59
#     REVISION:  ---
#===============================================================================

use 5.010;      # Require at least Perl version 5.10
use autodie;
use Getopt::Long; # use GetOptions function to for CL args
use warnings;
use strict;

my ($debug,$verbose,$help,$infile,$qual_only);

my $result = GetOptions(
    "debug"     =>  \$debug,
    "verbose"   =>  \$verbose,
    "infile:s"  =>  \$infile,
    "qual_only" =>  \$qual_only,
    "help"      =>  \$help,
);

if ($help) {
    help();
    exit(0);
}



#Copyright (c) 2010 LUQMAN HAKIM BIN ABDUL HADI (csilhah@nus.edu.sg)
#
#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files 
#(the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, 
#merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is 
#furnished to do so, subject to the following conditions:

#The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
#OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
#LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR 
#IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

use strict;

my $file = $ARGV[0];
open(FILE,"<",$infile);

my ($header, $sequence, $sequence_length, $sequence_quality);
while(<FILE>) {
    chomp $_;
    if ($_ =~ /^>(.+)/) {
        if($header ne "") {
            unless ($qual_only) {
                print "\@".$header."\n";
                print $sequence."\n";
            }
            print "+$header"."\n";
            print $sequence_quality."\n";
        }
        $header = $1;
        $sequence = "";
        $sequence_length = "";
        $sequence_quality = "";
    } else { 
        $sequence .= $_;
        $sequence_length = length($_); 
        for(my $i=0; $i<$sequence_length; $i++) {$sequence_quality .= "I"} 
    }
}
close FILE;
unless ($qual_only) {
    print "\@".$header."\n";
    print $sequence."\n";
}
print "+$header"."\n";
print $sequence_quality."\n";


sub help {

say <<HELP;

  
    "debug"     =>  \$debug,
    "verbose"   =>  \$verbose,
    "infile:s"  =>  \$infile,
    "qual_only" =>  \$qual_only,
    "help"      =>  \$help,


HELP

}




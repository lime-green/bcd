#!/usr/bin/perl
#
# Outputs the cd command to go to the right-most matched directory (prioritises directories other than the absolute right-most directory)
# Accepts regular expressions--just remember to enclose in single quotes if using shell special characters (*,!,etc.)
#
# USAGE: 
# function bcd(){ eval $(back_directory.pl $1); }
#
# EXAMPLE: if pwd = /users/tor/arqt/qko/joshua/scripts
# bcd qko ==> cd /users/tor/arqt/qko
# bcd t   ==> cd /users/tor/arqt
# bcd t[oa] ==> cd /users/tor
#
# Joshua Doncaster-Marsiglio
# Nov 2014
#

use strict;
use warnings;

# using getopt slows down the program considerably (by a factor of two)
#use Getopt::Long; # parses options

# debug option is for testing purposes (now used by providing a second argument as path)
#my $debug;
#GetOptions('debug|d' =>\$debug);

my $arg_c = $#ARGV + 1;

if ($arg_c != 1 && $arg_c != 2)
{
   print "Invalid number of arguments\n";
   exit 1;
}

my $cwd =  defined $ARGV[1] ? $ARGV[1] : `pwd;`;
my $input = $ARGV[0];
my ($parent_cwd) = $cwd =~ /(.*\/).*$/; #removes last directory (gets parent directory full path)
my $match;

# match found and input pattern has a trailing slash (no need to find corresponding slash)
if ((($match) = $parent_cwd =~ /(.*$input)/) && $match =~ /\/$/)
{
    print 'cd ', $match;
    exit 0;
}
# input pattern has no trailing slash, so looks for corresponding slash
elsif (($match) = $parent_cwd =~ /(.*$input.*?\/)/)
{
    print 'cd ', $match;
    exit 0;
}

# is the current directory or no match found - do nothing
else
{
    exit 0;
}

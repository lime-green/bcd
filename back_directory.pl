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

my $complete = 0;
my @paths;

if (defined $ARGV[0] && $ARGV[0] eq '--complete')
{
    $complete = 1;
    shift @ARGV;

    if (defined $ARGV[0] && $ARGV[0] !~ /^[a-zA-Z0-9\/]*$/){
        exit 1; # do not tab-complete when input is anything other than alpha-numeric and/or forward slash
    }

    # zero arguments supplied to --complete
    # so show all matches where the previous character was a forward slash (this will match the beginning [first character] of all directories)
    if ($#ARGV + 1 <= 0 || $ARGV[0] eq ''){
        $ARGV[0] = "(?<=\/)[^\/]"; 
    }
}

my $arg_c = $#ARGV + 1;
if ((! $complete) && (($#ARGV != 0 && $#ARGV != 1) || 
	(defined $ARGV[0] && $ARGV[0] eq '') ||
	(defined $ARGV[1] && $ARGV[1] eq '')))
{
    print STDERR "Invalid number of arguments\n";
    exit -1;
}

my $cwd =  defined $ARGV[1] ? $ARGV[1] : `pwd;`;
chomp $cwd; # pwd attaches a newline
my $input = $ARGV[0];
my $match;

# Compile all regex patterns
my $input_slash = qr/(.*$input)/;
my $input_noslash = qr/(.*$input.*?\/)/;
my $match_slash = qr/\/$/;
my $parent_dir = qr/(.+\/).*?\//;
my $expand_complete; 

# The first pattern is used when input does not start with a forward slash
# It captures the input pattern as well as anything until the next forward slash
$expand_complete = qr/.*\/[^\/]*($input[^\/]*\/)$/ if $input !~ /^\//;
$expand_complete = qr/.*($input[^\/]*\/)$/         if $input =~ /^\//;

if ($cwd eq '/')
{
    # current directory is root '/' (edge-case) DO NOTHING EVER
    exit 0;
}
my ($parent_cwd) = $cwd =~ /(.+\/).*?$/; #removes last directory (gets current directory's parent full path ALONG WITH ITS FORWARD SLASH)

if ($complete)
{
    while((defined $parent_cwd) && (($match) = $parent_cwd =~ $input_noslash))
    {
	my ($query) = $match =~ $expand_complete;
    $query =~ s/(\s)/\\$1/g; # escape whitespace
        push @paths, $query;
        ($parent_cwd) = $match =~ $parent_dir;
    }
    print join ":", grep {$_ ne $input} @paths;
    exit 0;
}
# match found and input pattern has a trailing slash (no need to find corresponding slash)
if ((($match) = $parent_cwd =~ $input_slash) && $match =~ $match_slash)
{
    print 'cd ', $match;
    exit 0;
}
# input pattern has no trailing slash, so looks for corresponding slash
elsif (($match) = $parent_cwd =~ $input_noslash)
{
    print 'cd ', $match;
    exit 0;
}

# is the current directory or no match found - do nothing
else
{
    exit 0;
}

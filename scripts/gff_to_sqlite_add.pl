#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use lib '/Users/Remo/src/BioPerl-1.6.1';
use lib '/Users/Remo/src/autocne';

use Bio::DB::SeqFeature::Store;
use Bio::DB::SeqFeature::Store::GFF3Loader;

my $USAGE = "\nperl $0 [gff file] [gff directory] [sqlite file] [sqlite directory]\n\n";

die $USAGE unless -d $ARGV[1];
chdir($ARGV[1]);
die $USAGE unless -e $ARGV[0];
die $USAGE unless $ARGV[0] =~ /\.gff$/;
system("cp $ARGV[1]\/$ARGV[0] $ARGV[3]\/");

die $USAGE unless -d $ARGV[3];
chdir($ARGV[3]);
die $USAGE unless -e $ARGV[2];
die $USAGE unless $ARGV[2] =~ /\.sqlite$/;

my $gff_file = $ARGV[0];
my $sql_file = $ARGV[2];

my $db = Bio::DB::SeqFeature::Store->new(-adaptor => 'DBI::SQLite',
                                         -dsn => $sql_file,
                                         -create => 0);

my $loader = Bio::DB::SeqFeature::Store::GFF3Loader->new(-store => $db,
							                                           -verbose => 1,
							                                           -fast => 1);

$loader->load($gff_file);

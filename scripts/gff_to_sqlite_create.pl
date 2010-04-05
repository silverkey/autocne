#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use lib '/Users/Remo/src/BioPerl-1.6.1';
use lib '/Users/Remo/src/autocne';

use Bio::DB::SeqFeature::Store;
use Bio::DB::SeqFeature::Store::GFF3Loader;

my $USAGE = "\nperl $0 [gff file] [directory]\n\n";
die $USAGE unless -d $ARGV[1];
chdir($ARGV[1]);
die $USAGE unless -e $ARGV[0];
die $USAGE unless $ARGV[0] =~ /\.gff$/;

my $gff_file = $ARGV[0];
my $sql_file = "$gff_file";
$sql_file =~ s/\.gff$/\.sqlite/;

my $db = Bio::DB::SeqFeature::Store->new(-adaptor => 'DBI::SQLite',
                                         -dsn => $sql_file,
                                         -create => 1);

my $loader = Bio::DB::SeqFeature::Store::GFF3Loader->new(-store => $db,
							                                           -verbose => 1,
							                                           -fast => 1);

$loader->load($gff_file);

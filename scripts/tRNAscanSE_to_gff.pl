#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use lib '/Users/Remo/src/BioPerl-1.6.1';
use lib '/Users/Remo/src/autocne';

use Bio::Tools::tRNAscanSE;


my $USAGE = "\nperl $0 [tRNAscanSE output file] [directory]\n\n";
die $USAGE unless -d $ARGV[1];
chdir($ARGV[1]);
die $USAGE unless -e $ARGV[0];

my $trna_file = $ARGV[0];
my $gff_file = "$trna_file";
$gff_file .= '.gff';

my $gffio = Bio::Tools::GFF->new(-file => ">$gff_file",
																 -gff_version => 3);

my $parser = Bio::Tools::tRNAscanSE->new(-file => $trna_file);

while(my $res = $parser->next_prediction) {
	$gffio->write_feature($res);
}

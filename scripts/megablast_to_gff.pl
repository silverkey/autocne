#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use lib '/Users/Remo/src/BioPerl-1.6.1';
use lib '/Users/Remo/src/autocne';

use Bio::Tools::GFF;
use Bio::SearchIO;

my $USAGE = "\nperl $0 [megablast output file in format 0] [directory]\n\n";
die $USAGE unless -d $ARGV[1];
chdir($ARGV[1]);
die $USAGE unless -e $ARGV[0];

my $blast_file = $ARGV[0];
my $gff_file = "$blast_file";
$gff_file .= '.gff';

my $gffio = Bio::Tools::GFF->new(-file => ">$gff_file",
																 -gff_version => 3);

my $in = Bio::SearchIO->new(-file => $blast_file,
                            -format => 'blast',
                            -report_format => 7);

while(my $res = $in->next_result) {
	while(my $hit = $res->next_hit) {
		while(my $hsp = $hit->next_hsp) {
			$hsp->feature1->add_tag_value('identity',$hsp->percent_identity);
			$gffio->write_feature($hsp->feature1);
		}
	}
}

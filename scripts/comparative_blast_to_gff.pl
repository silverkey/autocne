#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use lib '/Users/Remo/src/BioPerl-1.6.1';
use lib '/Users/Remo/src/autocne';

use Bio::Tools::GFF;
use Bio::SearchIO;

my $USAGE = "\nperl $0 [blast output file in format 0] [directory] [source]\n\n";
die $USAGE unless -d $ARGV[1];
chdir($ARGV[1]);
die $USAGE unless -e $ARGV[0];

my $blast_file = $ARGV[0];
my $gff_file = "$blast_file";
$gff_file .= '.gff';

open(OUT,">$gff_file");

my $in = Bio::SearchIO->new(-file => $blast_file,
                            -format => 'blast',
                            -report_format => 0);

while(my $res = $in->next_result) {
	while(my $hit = $res->next_hit) {
		while(my $hsp = $hit->next_hsp) {

      my $f1 = $hsp->feature1;
      my $f2 = $hsp->feature2;

      my $seq_id = $f1->seq_id;

      my $source = "$ARGV[2]\_BLASTN";

      my $type = 'match';

      my $start = $f1->start;

      my $end = $f1->end;

      my $score = $hsp->percent_identity;
      $score =~ s/^(\d+\.\d)\d+$/$1/;

      my $strand = $f2->strand;
      $strand = '+' if $strand eq '1';
      $strand = '-' if $strand eq '-1';

      my $phase = '0';

      my $attribute = 'Target='.$f2->seq_id.' '.$f2->start.' '.$f2->end.';'.'signif='.$hsp->evalue.';'.'Gap='.$hsp->cigar_string;

      print OUT $seq_id."\t".$source."\t".$type."\t".$start."\t".$end."\t".$score."\t".$strand."\t".$phase."\t".$attribute."\n";
		}
	}
}

close(OUT);

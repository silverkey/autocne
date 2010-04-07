#!/usr/bin/perl
use strict;
use warnings;
use Bio::SeqIO;
use Bio::Seq;


my $USAGE = "\nperl $0 [file silva.fasta] [directory] [specie]\n\n";
die $USAGE unless -d $ARGV[1];
chdir($ARGV[1]);
die $USAGE unless -e $ARGV[0];

my $rfam = $ARGV[0];
my $mod = $ARGV[2].'_'.$rfam;

my $in = Bio::SeqIO->new(-file => $rfam,
                         -format => 'fasta');

my $out = Bio::SeqIO->new(-file => ">$mod",
                          -format => 'fasta');

while(my $seq = $in->next_seq) {

  $out->write_seq($seq) if $seq->desc =~ /$ARGV[2]/;

}


#!/usr/bin/perl
use strict;
use warnings;
use Bio::SeqIO;
use Bio::Seq;

my $USAGE = "\nperl $0 [file Rfam.fasta] [directory]\n\n";
die $USAGE unless -d $ARGV[1];
chdir($ARGV[1]);
die $USAGE unless -e $ARGV[0];

my $rfam = $ARGV[0];
my $mod = 'mod'.$rfam;

my $in = Bio::SeqIO->new(-file => $rfam,
												 -format => 'fasta');

my $out = Bio::SeqIO->new(-file => ">$mod",
													-format => 'fasta');

my $c = 1;

while(my $seq = $in->next_seq) {

	my $id = $seq->id;
	my $desc = "$c:";
	$desc .= $seq->desc;
	$desc =~ s/\;/\:/g;
	$desc =~ s/\:$//g;
	my $seq = $seq->seq;

	my $new = Bio::Seq->new(-id => $desc,
													-desc => $id,
													-seq => $seq);

	$out->write_seq($new);

	$c++;
}

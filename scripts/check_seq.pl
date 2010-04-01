#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;
use Bio::SeqIO;

#
# This script check the consistency between the sequences fasta file distributed by the jgi
# and the genbank file downloaded from the ncbi genome project page.
# If the sequences are equal then it create a fasta file populated with the sequences from
# the fasta jgi and the id from the genbank genome project. This is because the jgi sequences
# are soft masked hence much more usable with BLAST, but the genbank id are necessary for
# the correct annotations.
#

my $USAGE = "\nUsage: perl $0 [genbank file] [jgi file]\n\n";
die $USAGE unless -e $ARGV[0];
die $USAGE unless -e $ARGV[1];

my $gb = $ARGV[0];
my $fa = $ARGV[1];

my $gbio = Bio::SeqIO->new(-file => $gb,
													 -format => 'genbank');

my $faio = Bio::SeqIO->new(-file => $fa,
													 -format => 'fasta');

my $gbhref = get_href($gbio);
my $fahref = get_href($faio);

my $outio = Bio::SeqIO->new(-file => ">$fa.checked",
														-format => 'fasta');

foreach my $key(keys %$fahref) {
	if(exists $gbhref->{uc($key)}) {
		my $seq = Bio::Seq->new(-id => $gbhref->{uc($key)},
														-seq => $key);
		$outio->write_seq($seq);
	}
	else {
		print $fahref->{$key}." has no correspondent!\n";
	}
}

sub get_href {
	my $io = shift;
	my $href = {};
	while(my $seq = $io->next_seq) {
		$href->{$seq->seq} = $seq->id;
	}
	return $href;
}

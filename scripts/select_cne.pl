#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use lib '/Users/Remo/src/BioPerl-1.6.1';
use lib '/Users/Remo/src/autocne';

use Bio::DB::SeqFeature::Store;

my $USAGE = "\nperl $0 [sqlite file] [directory]\n\n";
die $USAGE unless -d $ARGV[1];
chdir($ARGV[1]);
die $USAGE unless -e $ARGV[0];
die $USAGE unless $ARGV[0] =~ /\.sqlite$/;

my $sql_file = $ARGV[0];

my $db = Bio::DB::SeqFeature::Store->new(-adaptor => 'DBI::SQLite',
          							                 -dsn => $sql_file);

my @features = $db->get_features_by_type('similarity');

foreach my $feature(@features) {
	my @identity = $feature->get_tag_values('identity');
	my $identity = $identity[0];
	$identity =~ s/^(\d+\.\d)\d+$/$1/;
	my $length = $feature->length;
	print "$length\t$identity\t";
	print '*' if $length >= 100 && $identity >= 90;
	print "\n";
}

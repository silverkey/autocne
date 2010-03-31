#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use lib '/Users/Remo/src/BioPerl-1.6.1';
use lib '/Users/Remo/src/autocne';

use Bio::AutoCNE::Utils;

my $conf = Bio::AutoCNE::Utils->get_conf('../CONFIG');
chdir($conf->{data});

my $log = Bio::AutoCNE::Utils->start_log($conf);

my $command = 'perl -I '.$conf->{bioperl}.' '.$conf->{gb2gff3_script}.' -noCDS '.$conf->{gb_file}.' >> '.$log;

system $command;

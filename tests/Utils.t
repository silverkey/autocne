use strict;
use warnings;
use Data::Dumper;
use Test::More;

use_ok('Bio::AutoCNE::Utils');

my $conf = Bio::AutoCNE::Utils->get_conf('CONFIG');
ok($conf->{gb2gff3_script} eq '/Users/remo/src/BioPerl-1.6.1/scripts/Bio-DB-GFF/genbank2gff3.PLS', 'Bio::AutoCNE::Utils->get_conf() test');

my $copy = Bio::AutoCNE::Utils->start_log($conf);
ok(-e $copy, 'Bio::AutoCNE::Utils->copy_conf() test');
unlink($copy);

done_testing();

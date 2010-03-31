#!/usr/bin/perl

package Bio::AutoCNE::Utils;

use strict;
use warnings;
use Data::Dumper;

=head2 get_conf

 Title   : get_conf

 Usage   : my $conf = Bio::AutoCNE::Utils->get_conf($file);

 Function: read a simple configuration file and return an hasref with keys/values

 Returns : an hashref with keys as param names and values as param values

 Args    : -1 name with the path of the simple config file

 Note    :  the configuration file is very simple - Pay attention in what it needs:

            - The key on the left and the value on the rigth of the = symbol.
            - Comment lines start with # as usual........
            - Empty lines are not taken in consideration........
            - All the spaces are removed before to parse each line so DO NOT USE spaces inside the key/value.
            - Do not use " or ' or other strange symbols in the key/value they are not parsed and create problems.

=cut

sub get_conf {
	my $class = shift;
  my $conf = shift;
  my $href = {};
	die "\nFile $conf do not exists\n" unless -e $conf;
  open(IN,$conf);
  while(my $row = <IN>) {
		$row =~ s/^\s//g;
		$row =~ s/\s$//g;
    next if $row =~ /^\#/;
    next unless $row =~ /\=/;
    chomp($row);
    $row =~ s/\s+//g;
    my($key,$val) = split(/\=/,$row);
    $href->{$key} = $val;
  }
  return $href;
}


=head2 start_log

 Title   : start_log

 Usage   : Bio::AutoCNE::Utils->start_log($href);

 Function: create a file in which reverse the couples key/value of the config

 Returns : the name of the file created

 Args    : -1 the hashref returned by the function Bio::AutoCNE::Utils->get_conf()

 Note    : 

=cut

sub start_log {
	my $class = shift;
	my $href = shift;
	my $name = $0.'.log';
	open(OUT,">",$name) or die $!;
	foreach my $key(keys %$href) {
		my $value = $href->{$key};
		print OUT "$key = $value\n";
	}
	close(OUT);
	return $name;
}

1;

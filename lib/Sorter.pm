package Sorter;
use strict;
use warnings;

sub new {
    my $class = shift;
    my @empty = () ;
    my $self = {
	values => \@empty,
    };
    bless $self, $class;
}

sub set_values {
    my $self = shift;
    my @vals = @_;
    return $self->{values} = \@vals;
}

sub get_values {
    my $self = shift;
    my $vals = $self->{values};
    return @{$vals};
}

sub sort {
    my $self = shift;
    my $head = shift;
    my $tail = shift;

    if (!defined($head) && !defined($tail)) {
	return $self->sort(0, scalar @{$self->{values}});
    }

    if ($tail - $head < 1) { return; }

    my $rv = $self->{values};
    my $i = $head;
    my $j = $tail - 1;
    my $pivot = ( ${$rv}[$i]
		  + ${$rv}[$j]
		  + ${$rv}[($i + $j)/2]) / 3;

    while (1) {
	while (${$rv}[$i] < $pivot) { $i++; }
	while ($pivot < ${$rv}[$j]) { $j--; }
	if ($i >= $j) { last; }
	($$rv[$i], $$rv[$j]) = ($$rv[$j], $$rv[$i]);
	$i++;
	$j--;
    }

    if ($i - $head > 1) { $self->sort($head, $i); }
    if ($tail - $i > 1) { $self->sort($i, $tail); }
}

1;


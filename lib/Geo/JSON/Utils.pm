package Geo::JSON::Utils;

# VERSION

# ABSTRACT: Util methods for Geo::JSON classes

use strict;
use warnings;
use Carp;

use base 'Exporter';

our @EXPORT_OK = qw/ compare_positions compute_bbox /;

# TODO make better - need to ensure floating points are the same 
sub compare_positions {
    my ( $pos1, $pos2 ) = @_;

    foreach my $dim ( 0 .. $#{$pos1} ) {

        # TODO fix stringification problems...?
        return 0
            if ( defined $pos1->[$dim] && !defined $pos2->[$dim] )
            || ( !defined $pos1->[$dim] && defined $pos2->[$dim] )
            || ( $pos1->[$dim] != $pos2->[$dim] );
    }
    return 1;
}

sub compute_bbox {
    my $positions = shift;    # arrayref of positions

    croak "Need an array of at least 2 positions"
        unless ref $positions
        && ref $positions eq 'ARRAY'
        && @{$positions} > 1;

    # NOTE assumes all have same number of dimensions!

    my $dims = $#{ $positions->[0] };

    my @min = my @max = @{ $positions->[0] };

    foreach my $position ( @{$positions} ) {
        foreach my $d ( 0 .. $dims ) {
            $min[$d] = $position->[$d] if $position->[$d] < $min[$d];
            $max[$d] = $position->[$d] if $position->[$d] > $min[$d];
        }
    }

    return [ @min, @max ];
}


1;


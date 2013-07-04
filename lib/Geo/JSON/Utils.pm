package Geo::JSON::Utils;

# VERSION

# ABSTRACT: Util methods for Geo::JSON classes

use strict;
use warnings;
use Carp;

use base 'Exporter';

our @EXPORT_OK = qw/ compare_positions /;

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

1;


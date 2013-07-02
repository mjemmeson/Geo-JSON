package Geo::JSON::Base;

use Carp;

use Moo;

sub inflate {
    my ( $class, $args ) = @_;

    croak "coordinates missing" unless $args->{coordinates};

    return $class->new( { coordinates => $args->{coordinates} } );
}

1;


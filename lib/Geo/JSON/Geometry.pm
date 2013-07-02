package Geo::JSON::Geometry;

# VERSION

use Moo;
extends 'Geo::JSON::Base';

use Types::Standard qw/ Any /;

has coordinates => (is => 'ro', isa => Any, required => 1 );

sub create {
    my $class = shift;

    return $class->new( { coordinates => shift } );
}

1;


package Geo::JSON::GeometryCollection;

# VERSION

# ABSTRACT: object representing a geojson GeometryCollection

use Moo;
extends 'Geo::JSON::Base';

use Carp;
use Types::Standard qw/ ArrayRef /;
use Geo::JSON::Types -types;

has geometries =>
    ( is => 'ro', isa => ArrayRef [Geometry], required => 1 );

sub all_positions {
    my $self = shift;

    return [ map { @{ $_->all_positions } } @{ $self->geometries } ];
}

1;


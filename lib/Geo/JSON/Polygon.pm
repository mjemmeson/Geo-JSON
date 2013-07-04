package Geo::JSON::Polygon;

# VERSION

# ABSTRACT: object representing a geojson Polygon

use Moo;
extends 'Geo::JSON::Geometry';

use Geo::JSON::Types -types;

has '+coordinates' => ( isa => Polygon );

sub all_positions {
    my $self = shift;

    return [
        map { @{$_} }
        map { @{$_} } @{ $self->coordinates }
    ];
}

1;


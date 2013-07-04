package Geo::JSON::MultiPoint;

# VERSION

# ABSTRACT: object representing a geojson MultiPoint

use Moo;
extends 'Geo::JSON::Geometry';

use Geo::JSON::Types -types;

has '+coordinates' => ( isa => Positions );

sub all_positions {
    my $self = shift;

    return [ map { @{$_} } @{ $self->coordinates } ];
}

1;


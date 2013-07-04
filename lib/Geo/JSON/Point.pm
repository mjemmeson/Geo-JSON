package Geo::JSON::Point;

# VERSION

# ABSTRACT: object representing a geojson Point

use Moo;
extends 'Geo::JSON::Geometry';

use Carp;

use Geo::JSON::Types -types;

has '+coordinates' => ( isa => Position );

around compute_bbox => sub {
    croak "Can't compute_bbox with a single position";
};

1;


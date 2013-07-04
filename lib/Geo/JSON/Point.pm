package Geo::JSON::Point;

# VERSION

# ABSTRACT: object representing a geojson Point

use Moo;
extends 'Geo::JSON::Geometry';

use Geo::JSON::Types -types;

has '+coordinates' => ( isa => Position );

1;


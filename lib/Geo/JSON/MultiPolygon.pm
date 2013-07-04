package Geo::JSON::MultiPolygon;

# VERSION

# ABSTRACT: object representing a geojson MultiPolygon

use Moo;
extends 'Geo::JSON::Geometry';

use Geo::JSON::Types -types;

has '+coordinates' => ( isa => Polygons );

1;


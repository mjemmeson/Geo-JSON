package Geo::JSON::MultiPolygon;

# VERSION

# ABSTRACT: object representing a geojson MultiPolygon

use Moo;
extends 'Geo::JSON::Geometry';

use Geo::JSON::Types qw/ Polygons /;

has '+coordinates' => ( isa => Polygons );

1;


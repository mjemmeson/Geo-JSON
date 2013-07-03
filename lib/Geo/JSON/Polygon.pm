package Geo::JSON::Polygon;

# VERSION

# ABSTRACT: object representing a geojson Polygon

use Moo;
extends 'Geo::JSON::Geometry';

use Geo::JSON::Types qw/ Polygon /;

has '+coordinates' => ( isa => Polygon );

1;


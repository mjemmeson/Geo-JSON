package Geo::JSON::MultiPolygon;

# VERSION

use Moo;
extends 'Geo::JSON::Geometry';

use Geo::JSON::Types qw/ Polygons /;

has '+coordinates' => ( isa => Polygons );

1;


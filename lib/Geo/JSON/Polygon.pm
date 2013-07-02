package Geo::JSON::Polygon;

use Moo;
extends 'Geo::JSON::Geometry';

use Geo::JSON::Types qw/ Polygon /;

has '+coordinates' => ( isa => Polygon );

1;


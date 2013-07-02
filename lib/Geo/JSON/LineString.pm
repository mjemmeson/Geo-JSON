package Geo::JSON::LineString;

use Moo;
extends 'Geo::JSON::Geometry';

use Geo::JSON::Types qw/ LineString /;

has '+coordinates' => ( isa => LineString );

1;


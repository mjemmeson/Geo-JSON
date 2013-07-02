package Geo::JSON::Point;

# VERSION

use Moo;
extends 'Geo::JSON::Geometry';

use Geo::JSON::Types qw/ Position /;

has '+coordinates' => ( isa => Position );

1;


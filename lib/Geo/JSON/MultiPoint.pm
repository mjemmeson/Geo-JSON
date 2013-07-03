package Geo::JSON::MultiPoint;

# VERSION

# ABSTRACT: object representing a geojson MultiPoint

use Moo;
extends 'Geo::JSON::Geometry';

use Geo::JSON::Point;
use Geo::JSON::Types qw/ Position Positions /;

has '+coordinates' => ( isa => Positions );

1;


package Geo::JSON::MultiLineString;

# VERSION

# ABSTRACT: object representing a geojson MultiLineString

use Moo;
extends 'Geo::JSON::Geometry';

use Geo::JSON::Types qw/ LineStrings /;

has '+coordinates' => ( isa => LineStrings );

1;


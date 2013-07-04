package Geo::JSON::Geometry;

# VERSION

# ABSTRACT: object representing a geojson Geometry

use Moo;
extends 'Geo::JSON::Base';

use Types::Standard qw/ Any /;

has coordinates => (is => 'ro', isa => Any, required => 1 );

1;


package Geo::JSON::BaseObject;

# VERSION

# ABSTRACT: Base class for Geo::JSON objects

use Moo;
extends 'Geo::JSON::Base';

use Carp;

use Types::Standard qw/ Maybe ArrayRef Num /;

use Geo::JSON::Types -types;

has crs => ( is => 'ro', isa => Maybe [CRS], coerce => CRS->coercion );

has bbox => ( is => 'rw', isa => Maybe [ ArrayRef [Num] ] );

sub type {
    return ( ( ref $_[0] ) =~ m/::(\w+)$/ )[0];
}

1;


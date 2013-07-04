package Geo::JSON::FeatureCollection;

# VERSION

# ABSTRACT: object representing a geojson FeatureCollection

use Moo;
extends 'Geo::JSON::Base';

use Carp;
use Types::Standard qw/ ArrayRef HashRef /;

use Geo::JSON::Types -types;

has features => (
    is       => 'ro',
    isa      => Features,
    coerce   => Features->coercion,
    required => 1
);

sub all_positions {
    my $self = shift;
    return [ map { @{ $_->all_positions } } @{ $self->features } ];
}

1;


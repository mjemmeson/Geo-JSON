package Geo::JSON::MultiLineString;

# VERSION

# ABSTRACT: object representing a geojson MultiLineString

use Moo;
extends 'Geo::JSON::Geometry';

use Geo::JSON::Types -types;

has '+coordinates' => ( isa => LineStrings );

sub all_positions {
    my $self = shift;

    return [
        map { @{$_} }
        map { @{$_} } @{ $self->coordinates }
    ];
}

1;


package Geo::JSON::Feature;

# VERSION

# ABSTRACT: object representing a geojson Feature

use Moo;
extends 'Geo::JSON::Base';

use Carp;
use Types::Standard qw/ Str Maybe HashRef /;
use Geo::JSON::Types qw/ Geometry /;
use Geo::JSON::Utils;

has id => ( is => 'ro', isa => Maybe [Str] );
has geometry =>
    ( is => 'ro', isa => Geometry, required => 1 );
has properties => ( is => 'ro', isa => Maybe [HashRef] );

sub inflate {
    my ( $class, $args ) = @_;

    my $geometry = $args->{geometry}
        or croak "Geometry missing";

    return $class->new(
        {   id         => $args->{id},
            properties => $args->{properties},
            geometry   => Geo::JSON::Utils::inflate($geometry),
        }
    );
}

1;


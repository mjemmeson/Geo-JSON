package Geo::JSON::GeometryCollection;

# VERSION

# ABSTRACT: object representing a geojson GeometryCollection

use Moo;
extends 'Geo::JSON::Base';

use Carp;
use Types::Standard qw/ ArrayRef /;
use Geo::JSON::Types qw/ Geometry /;
use Geo::JSON::Utils;

has geometries =>
    ( is => 'ro', isa => ArrayRef [Geometry], required => 1 );

sub inflate {
    my ( $class, $args ) = @_;

    my $geometries = $args->{geometries} or croak "geometries missing";

    return $class->new(
        {   geometries =>
                [ map { Geo::JSON::Utils::inflate($_) } @{$geometries} ]
        }
    );
}

1;


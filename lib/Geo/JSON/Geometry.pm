package Geo::JSON::Geometry;

# VERSION

# ABSTRACT: object representing a geojson Geometry

use Moo;
extends 'Geo::JSON::BaseObject';

use Types::Standard qw/ Any /;

use Geo::JSON::Utils;

has coordinates => ( is => 'ro', isa => Any, required => 1 );

sub compute_bbox {
    return Geo::JSON::Utils::compute_bbox( shift->all_positions );
}

sub all_positions {
    my $self = shift;
    return $self->coordinates;
}

=head1 DESCRIPTION

Base class for GeoJSON geometry objects (Point, MultiPoint, LineString,
MultiLineString, Polygon, MultiPolygon).

=cut

1;


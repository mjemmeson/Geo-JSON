package Geo::JSON::Role::Geometry;

# VERSION

# ABSTRACT: Moo::Role representing behaviour of a geojson Geometry object

use Moo::Role;

use Types::Standard qw/ Any /;

has coordinates => ( is => 'ro', isa => Any, required => 1 );

=head1 DESCRIPTION

L<Moo::Role> for GeoJSON geometry objects (Point, MultiPoint, LineString,
MultiLineString, Polygon, MultiPolygon).

See L<Geo::JSON> for more details.

=head1 ATTRIBUTES

=head2 coordinates

=cut

1;


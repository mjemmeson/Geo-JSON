package Geo::JSON;

# VERSION

# ABSTRACT: Perl OO interface for geojson 

use strict;
use warnings;
use Carp;

use JSON qw/ decode_json /;
use Geo::JSON::Utils qw/ inflate /;

=head1 SYNOPSIS

    use Geo::JSON;
    
    my $obj = Geo::JSON->from_json( $json );

=head1 DESCRIPTION

Convert to and from geojson using Perl objects. See the individual object
classes for more details.

Currently in development - feedback welcome.

Currently supports 2 or 3 dimensions (longitude, latitude, altitude). If there
is a case for increasing this to support a higher or arbitrary number please
let me know.

=head1 GEOJSON SPECIFICATION

See: L<http://www.geojson.org/geojson-spec.html>

=head1 OBJECTS

=over

=item *

L<Geo::JSON::Point>

=item *

L<Geo::JSON::MultiPoint>

=item *

L<Geo::JSON::LineString>

=item *

L<Geo::JSON::MultiLineString>

=item *

L<Geo::JSON::Polygon>

=item *

L<Geo::JSON::MultiPolygon>

=item *

L<Geo::JSON::GeometryCollection>

=item *

L<Geo::JSON::Feature>

=item *

L<Geo::JSON::FeatureCollection>

=back

=head1 METHODS

=head2 from_json

    my $obj = Geo::JSON->from_json( $json );

Takes a geojson string, returns the object it represents.

=cut

sub from_json {
    my ( $class, $json ) = @_;

    my $data = decode_json($json);

    return inflate $data;
}

=head1 TODO

=over

=item *

Floating point maths, check scientific notation etc

=item *

CRS values

=item *

Validation of lat/long/altitude? (linked to CRS?)

=back

=cut

1;


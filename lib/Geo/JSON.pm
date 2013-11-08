package Geo::JSON;

# VERSION

# ABSTRACT: Perl OO interface for geojson

use strict;
use warnings;
use Carp;

use JSON qw/ decode_json /;

use Geo::JSON::CRS;
use Geo::JSON::FeatureCollection;
use Geo::JSON::Feature;
use Geo::JSON::GeometryCollection;
use Geo::JSON::Geometry;
use Geo::JSON::LineString;
use Geo::JSON::MultiLineString;
use Geo::JSON::MultiPoint;
use Geo::JSON::MultiPolygon;
use Geo::JSON::Point;
use Geo::JSON::Polygon;

our $json = JSON->new->utf8->convert_blessed(1);

=head1 SYNOPSIS

    use Geo::JSON;
    
    my $obj = Geo::JSON->from_json( $json );
    
    $obj->to_json();

=head1 DESCRIPTION

Convert to and from geojson using Perl objects. GeoJSON objects represent
various geographical positions - points, lines, polygons, etc.

Currently in development - feedback welcome.

Currently supports 2 or 3 dimensions (longitude, latitude, altitude). Further
dimensions in positions are ignored for calculations and comparisons, but will
be read-from and written-to.

=head1 GEOJSON SPECIFICATION

See: L<http://www.geojson.org/geojson-spec.html>

=head1 GEOJSON MEMBERS (ATTRIBUTES)

See the specification for the full details, but the basics are as follows:

=over

=item * C<type>

Determines the object the json will be turned into

=item * C<position>

Not explicitly named in the json, but an array of at least two numbers
representing a location in x, y, z order. (Either Easting, Northing, Altitude
or Longitude, Latitude, Altitude as appropriate).

Additional numbers may be present but ignored by this package for
calculations.

=item * C<coordinates>

Defined in geometry objects (Point, MultiPoint, LineString, MultiLineString,
Polygon, MultiPolygon). Will consist of a single position (Point), an array
of positions (MultiPoint, LineString), an array of arrays of positions
(MultiLineString, Polygon) or an array of arrays of arrays of positions
(MultiPolygon). The positions within a single object should all have the same
number of axes and be in the same axis order.

=item * C<bbox>

Optional, defining a bounding box that the position(s) are contained by.
FIXME define bbox

=item * C<crs>

Optional, defining the Co-ordinates Reference System the object is using. See
L<Geo::JSON::CRS> for more details.

=back

=head1 OBJECTS

=over

=item * L<Geo::JSON::Point>

A single position

=item * L<Geo::JSON::MultiPoint>

An array of positions, representing multiple points

=item * L<Geo::JSON::LineString>

An array of 2 or more positions, represening a connected line

=item * L<Geo::JSON::MultiLineString>

An array of lines

=item * L<Geo::JSON::Polygon>

An array of lines, defining a polygon. The first line represents the outside
of the polygon, subsequent lines define any 'holes'. The lines must be
'linear rings' - 4 or more points, with the first and last points being
equivalent.

=item * L<Geo::JSON::MultiPolygon>

An array of polygons

=item * L<Geo::JSON::GeometryCollection>

An array of any of the above Geometry objects (as attribute C<geometries>)

=item * L<Geo::JSON::Feature>

Any of the above objects (as attribute C<feature>), together with a data
structure (as attruibute C<properties>)

=item * L<Geo::JSON::FeatureCollection>

An array of Feature objects (as attribute C<features>)

=back

=head1 METHODS

=head2 from_json

    my $obj = Geo::JSON->from_json( $json );

Takes a geojson string, returns the object it represents.

=cut

sub from_json {
    my ( $class, $json ) = @_;

    my $data = decode_json($json);

    croak "from_json requires a JSON object (hashref)"
        unless ref $data eq 'HASH';

    my $type = delete $data->{type}
        or croak "Invalid JSON data: no type specified";

    my $geo_json_class = 'Geo::JSON::' . $type;

    return $geo_json_class->new($data);
}

=head1 CLASS METHODS

=head2 codec

    Geo::JSON->codec->canonical(1)->pretty;
    
    my $prev_codec = Geo::JSON->codec($new_codec);

Set options on or replace L<JSON> codec.

=cut

sub codec {
    my $class = shift;

    my $orig = $json;
    $json = shift if @_;

    return $orig;
}

=head1 THANKS

Tim Bunce - for codec suggestions and bug spotting.

=cut

1;


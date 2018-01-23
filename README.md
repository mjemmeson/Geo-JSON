# NAME

Geo::JSON - Perl OO interface for geojson

# SYNOPSIS

    use Geo::JSON;
    
    my $obj = Geo::JSON->from_json( $json );
    
    $obj->to_json();

# DESCRIPTION

Convert to and from geojson using Perl objects. GeoJSON objects represent
various geographical positions - points, lines, polygons, etc.

Currently supports 2 or 3 dimensions (longitude, latitude, altitude). Further
dimensions in positions are ignored for calculations and comparisons, but will
be read-from and written-to.

# GEOJSON SPECIFICATION

See: [RFC 7946](https://tools.ietf.org/html/rfc7946)

# GEOJSON MEMBERS (ATTRIBUTES)

See the specification for the full details, but the basics are as follows:

- `type`

    Determines the object the json will be turned into

- `position`

    Not explicitly named in the json, but an array of at least two numbers
    representing a location in x, y, z order (either Easting, Northing, Altitude
    or Longitude, Latitude, Altitude as appropriate).

    Additional numbers may be present but ignored by this package for
    calculations.

- `coordinates`

    Defined in geometry objects (Point, MultiPoint, LineString, MultiLineString,
    Polygon, MultiPolygon). Will consist of a single position (Point), an array
    of positions (MultiPoint, LineString), an array of arrays of positions
    (MultiLineString, Polygon) or an array of arrays of arrays of positions
    (MultiPolygon). The positions within a single object should all have the same
    number of axes and be in the same axis order.

- `bbox`

    Optional, defining a bounding box that the position(s) are contained by.

    The box is defined by a array of 2\*n items, where n is the number of
    dimensions in a position. The items are the lowest value for an axis followed
    by the highest value for an axis, in the axis order used in the positions.

    The Co-ordinates Reference System for the bounding box is assumed to match
    that of the object.

- `crs`

    Optional, defining the Co-ordinates Reference System the object is using. See
    [Geo::JSON::CRS](https://metacpan.org/pod/Geo::JSON::CRS) for more details.

# GEOMETRY OBJECTS

- [Geo::JSON::Point](https://metacpan.org/pod/Geo::JSON::Point)

    A single position

- [Geo::JSON::MultiPoint](https://metacpan.org/pod/Geo::JSON::MultiPoint)

    An array of positions, representing multiple points

- [Geo::JSON::LineString](https://metacpan.org/pod/Geo::JSON::LineString)

    An array of 2 or more positions, represening a connected line

- [Geo::JSON::MultiLineString](https://metacpan.org/pod/Geo::JSON::MultiLineString)

    An array of lines

- [Geo::JSON::Polygon](https://metacpan.org/pod/Geo::JSON::Polygon)

    An array of lines, defining a polygon. The first line represents the outside
    of the polygon, subsequent lines define any 'holes'. The lines must be
    'linear rings' - 4 or more points, with the first and last points being
    equivalent.

- [Geo::JSON::MultiPolygon](https://metacpan.org/pod/Geo::JSON::MultiPolygon)

    An array of polygons

- [Geo::JSON::GeometryCollection](https://metacpan.org/pod/Geo::JSON::GeometryCollection)

    An array of any of the above Geometry objects (as attribute `geometries`)

# FEATURE OBJECTS

- [Geo::JSON::Feature](https://metacpan.org/pod/Geo::JSON::Feature)

    Any of the above objects (as attribute `feature`), together with a data
    structure (as attruibute `properties`)

# FEATURE COLLECTION OBJECTS

- [Geo::JSON::FeatureCollection](https://metacpan.org/pod/Geo::JSON::FeatureCollection)

    An array of Feature objects (as attribute `features`)

# METHODS

## from\_json

    my $obj = Geo::JSON->from_json( $json );

Takes a geojson string, returns the object it represents.

## to\_json

    $obj->to_json();
    $obj->to_json( $codec );

Call on a Geo::JSON object. Returns the JSON that represents the object.

Pass in an optional [JSON](https://metacpan.org/pod/JSON) codec to modify the default behaviour of the JSON
returned.

## load

    my $obj = Geo::JSON->load( { type => 'Point', coordinates => ... } );

Creates a Geo::JSON object from a hashref.

This is used for coercion of attributes during object creation, and probably
should not be called directly otherwise.

# CLASS METHODS

## codec

    Geo::JSON->codec->canonical(1)->pretty;
    
    my $prev_codec = Geo::JSON->codec($new_codec);

Set options on or replace [JSON](https://metacpan.org/pod/JSON) codec.

# THANKS

Tim Bunce - for codec suggestions and bug spotting.

# SEE ALSO

- [Geo::JSON::Simple](https://metacpan.org/pod/Geo::JSON::Simple) - simple interface to create Geo::JSON objects.

# SUPPORT

## Bugs / Feature Requests

Please report any bugs or feature requests through the issue tracker
at [https://github.com/mjemmeson/Geo-JSON/issues](https://github.com/mjemmeson/Geo-JSON/issues).
You will be notified automatically of any progress on your issue.

## Source Code

This is open source software.  The code repository is available for
public review and contribution under the terms of the license.

[https://github.com/mjemmeson/Geo-JSON](https://github.com/mjemmeson/Geo-JSON)

    git clone https://github.com/mjemmeson/Geo-JSON.git

# AUTHOR

Michael Jemmeson <mjemmeson@cpan.org>

# CONTRIBUTORS

Mohammad S Anwar \[MANWAR\]

# COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Michael Jemmeson <mjemmeson@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

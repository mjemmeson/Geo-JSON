package GeoJSONTests;

use strict;
use warnings;

use Class::Load qw/ load_class /;
use JSON ();

my $json = JSON->new->pretty->canonical(1)->utf8;

my %DEFAULT_ARGS = (
    Point => { coordinates => [ 1, 2 ] },
    MultiPoint => { coordinates => [ [ 1, 2 ], [ 3, 4 ] ] },
    LineString => { coordinates => [ [ 1, 2 ], [ 3, 4 ] ] },
    MultiLineString =>
        { coordinates => [ [ [ 1, 2 ], [ 3, 4 ] ], [ [ 5, 6 ], [ 7, 8 ] ] ] },
    Polygon => {
        coordinates =>
            [ [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ], [ 7, 8 ], [ 1, 2 ] ] ]
    },
    MultiPolygon => {
        coordinates => [
            [ [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ], [ 7, 8 ], [ 1, 2 ] ] ],
            [ [ [ 9, 8 ], [ 7, 6 ], [ 5, 4 ], [ 3, 2 ], [ 9, 8 ] ] ]
        ],
    },
    Feature => { geometry => { type => 'Point', coordinates => [ 1, 2 ] } },
    FeatureCollection => {
        features => [
            {   type     => 'Feature',
                geometry => { type => 'Point', coordinates => [ 1, 2 ] }
            },
            {   type     => 'Feature',
                geometry => {
                    type        => 'MultiPoint',
                    coordinates => [ [ 1, 2 ], [ 3, 4 ] ]
                }
            },
        ],
    },
    CRS => {
        type       => 'name',
        properties => { name => 'urn:ogc:def:crs:OGC:1.3:CRS84' }
    },
);

sub types { sort keys %DEFAULT_ARGS }

sub geometry_types {
    sort grep { $DEFAULT_ARGS{$_}->{coordinates} } keys %DEFAULT_ARGS;
}

sub json {
    my ( $class, $type, $args ) = @_;

    return $type eq 'CRS'
        ? $json->encode($args)
        : $json->encode( { type => $type, %{$args} } );
}

sub object {
    my ( $class, $type, $args ) = @_;

    my $object_class = 'Geo::JSON::' . $type;

    load_class $object_class;

    $args ||= $DEFAULT_ARGS{$type};

    my $construct_args = $type eq 'CRS' ? $args : { type => $type, %{$args} };

    return $object_class->new($construct_args);
}

# sub Point {
#     return { coordinates => $_[1]->{coordinates}, type => 'Point' };
# }

# sub MultiPoint {
#     return { coordinates => $_[1]->{coordinates}, type => 'MultiPoint' };
# }

# sub LineString {
#     return { coordinates => $_[1]->{coordinates}, type => 'LineString' };
# }

# sub MultiLineString {
#     return { coordinates => $_[1]->{coordinates}, type => 'MultiLineString' };
# }

# sub Polygon {
#     return { coordinates => $_[1]->{coordinates}, type => 'Polygon' };
# }

# sub MultiPolygon {
#     return { coordinates => $_[1]->{coordinates}, type => 'MultiPolygon' };
# }

# sub Feature {
#     return {
#         geometry   => $_[1]->{geometry},
#         properties => $_[1]->{properties} || {},
#         type       => 'Feature'
#     };
# }

# sub FeatureCollection {
#     return {
#         features   => $_[1]->{features},
#         properties => $_[1]->{properties} || {},
#         type       => 'FeatureCollection'
#     };
# }

1;


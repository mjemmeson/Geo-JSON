package GeoJSONTests;

use strict;
use warnings;

use JSON ();

my $json = JSON->new->pretty->utf8;

sub json {
    my ($class,$type,$args) = @_;

    return $json->encode( $class->$type($args) );
}

sub Point {
    return { coordinates => $_[1]->{coordinates}, type => 'Point' };
}

sub MultiPoint {
    return { coordinates => $_[1]->{coordinates}, type => 'MultiPoint' };
}

sub LineString {
    return { coordinates => $_[1]->{coordinates}, type => 'LineString' };
}

sub MultiLineString {
    return { coordinates => $_[1]->{coordinates}, type => 'MultiLineString' };
}

sub Polygon {
    return { coordinates => $_[1]->{coordinates}, type => 'Polygon' };
}

1;


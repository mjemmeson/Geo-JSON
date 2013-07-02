package Geo::JSON;

# VERSION

# ABSTRACT: Perl interface for Geojson 

use strict;
use warnings;
use Carp;

use JSON qw/ decode_json /;
use Geo::JSON::Utils qw/ inflate /;

sub from_json {
    my ( $class, $json ) = @_;

    my $data = decode_json($json);

    return inflate $data;
}

1;


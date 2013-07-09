package Geo::JSON::Point;

# VERSION

# ABSTRACT: object representing a geojson Point

use Moo;
extends 'Geo::JSON::Geometry';

use Carp;

use Geo::JSON::Types -types;

has '+coordinates' => ( isa => Position );

around compute_bbox => sub {
    croak "Can't compute_bbox with a single position";
};

=head1 SYNOPSIS

    use Geo::JSON::Point;
    my $pt = Geo::JSON::Point->new({
        coordinates => [ 51.50101, -0.14159 ],
    });
    my $json = $pt->to_json;

=head1 DESCRIPTION

A GeoJSON object with a coordinates attribute of a single position.

=cut

1;


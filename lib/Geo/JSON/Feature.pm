package Geo::JSON::Feature;

# VERSION

# ABSTRACT: object representing a geojson Feature

use Moo;
extends 'Geo::JSON::BaseObject';

use Carp;
use Type::Utils qw( class_type );
use Types::Standard qw/ Str Maybe HashRef /;

use Geo::JSON::Types -types;

has id => ( is => 'ro', isa => Maybe [Str] );

has geometry => (
    is       => 'ro',
    isa      => Geometry,
    coerce   => Geometry->coercion,
    required => 1
);

has properties => ( is => 'ro', isa => Maybe [HashRef] );

sub all_positions {
    my $self = shift;

    return [ $self->geometry->all_positions ];
}

=head1 SYNOPSIS

    use Geo::JSON::Feature;
    my $ft = Geo::JSON::Feature->new({
        geometry   => $geometry_object,
        properties => \%properties,
    });
    my $json = $ft->to_json;

=head1 DESCRIPTION

A GeoJSON object with a geometry attribute of a single Geometry object and
an optional properties attribute.

=cut

1;


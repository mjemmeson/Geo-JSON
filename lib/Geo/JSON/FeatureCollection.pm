package Geo::JSON::FeatureCollection;

# VERSION

# ABSTRACT: object representing a geojson FeatureCollection

use Moo;
extends 'Geo::JSON::BaseObject';

use Carp;
use Types::Standard qw/ ArrayRef HashRef /;

use Geo::JSON::Types -types;

has features => (
    is       => 'ro',
    isa      => Features,
    coerce   => Features->coercion,
    required => 1
);

sub all_positions {
    my $self = shift;
    return [ map { @{ $_->all_positions } } @{ $self->features } ];
}

=head1 SYNOPSIS

    use Geo::JSON::FeatureCollection;
    my $fcol = Geo::JSON::FeatureCollection->new({
         features => \@features,
    });
    my $json = $fcol->to_json;

=head1 DESCRIPTION

A GeoJSON object with a features attribute of an arrayref of
L<Geo::JSON::Feature> objects.

See L<Geo::JSON> for more details.

=cut

1;


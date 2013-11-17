package Geo::JSON::MultiPoint;

# VERSION

# ABSTRACT: object representing a geojson MultiPoint

use Moo;
extends 'Geo::JSON::Geometry';

use Geo::JSON::Types -types;

has '+coordinates' => ( isa => Positions );

sub all_positions {
    my $self = shift;

    return [ map { @{$_} } @{ $self->coordinates } ];
}

=head1 SYNOPSIS

    use Geo::JSON::MultiPoint;
    my $mpt = Geo::JSON::Point->new({
        coordinates => [ [ 51.50101, -0.14159 ],
                         [ 57.596278, -13.687306 ],
                       ],
    });
    my $json = $mpt->to_json;

=head1 DESCRIPTION

A GeoJSON object with a coordinates attribute consisting of an arrayref of
positions.

See L<Geo::JSON> for more details.

=cut

1;


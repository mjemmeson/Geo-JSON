package Geo::JSON::BaseObject;

# VERSION

# ABSTRACT: Base class for Geo::JSON objects

use Moo;
extends 'Geo::JSON::Base';

use Carp;

use Types::Standard qw/ Maybe ArrayRef Num /;

use Geo::JSON::Types -types;
use Geo::JSON::Utils;

has crs => ( is => 'ro', isa => Maybe [CRS], coerce => CRS->coercion );

has bbox => ( is => 'rw', isa => Maybe [ ArrayRef [Num] ] );

=head1 DESCRIPTION

Base class for Geojson objects.

See L<Geo::JSON> for more details.

=head1 ATTRIBUTES

=head2 crs

Optional L<Geo::JSON::CRS> object to define the Co-ordinates Reference System
used by this object.

=head2 bbox

Optional arrayref representing a bounding box that encloses the points defined
by this Geojson object. See L<Geo::JSON> for more details.

=cut

# used by JSON 'convert_blessed'
sub TO_JSON {
    my $self = $_[0];

    my %output = (
        type => $self->type,
        %{$self},
    );

    # prevent empty 'crs' key
    delete $output{crs}
        unless defined $output{crs};

    return \%output;
}

=head1 METHODS

=head2 compute_bbox

Returns arrayref representing a Geojson bounding box that encloses the points
in the object's geometry.

=head2 all_positions

Returns arrayref of all positions (each an arrayref of C<n> dimensions) in the
object's geometry.

=cut

sub compute_bbox {
    return Geo::JSON::Utils::compute_bbox( shift->all_positions );
}

sub all_positions {
    return shift->coordinates;
}

1;


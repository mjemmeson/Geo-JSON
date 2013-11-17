package Geo::JSON::BaseObject;

# VERSION

# ABSTRACT: Base class for Geo::JSON objects

use Moo;
extends 'Geo::JSON::Base';

use Carp;

use Types::Standard qw/ Maybe ArrayRef Num /;

use Geo::JSON::Types -types;

has crs => ( is => 'ro', isa => Maybe [CRS], coerce => CRS->coercion );

has bbox => ( is => 'rw', isa => Maybe [ ArrayRef [Num] ] );

sub type {
    return ( ( ref $_[0] ) =~ m/::(\w+)$/ )[0];
}

=head1 DESCRIPTION

Base class for Geojson objects.

See L<Geo::JSON> for more details.

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

1;


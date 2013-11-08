package Geo::JSON::Base;

# VERSION

# ABSTRACT: Base class for Geo::JSON objects

use Moo;

use Carp;
use Types::Standard qw/ Maybe ArrayRef Num /;

use Geo::JSON;
use Geo::JSON::Types -types;

has crs => ( is => 'ro', isa => Maybe [CRS], coerce => CRS->coercion );

has bbox => ( is => 'rw', isa => Maybe [ ArrayRef [Num] ] );

sub type {
    return ( ( ref $_[0] ) =~ m/::(\w+)$/ )[0];
}

=head1 DESCRIPTION

Base class for object representing Geojson types.

=head1 METHODS

=head2 to_json

    $point->to_json();
    # or with custom JSON codec
    $point->to_json( $codec );

=cut

sub to_json {
    my $self = shift;
    my $codec = shift || $Geo::JSON::json;
    return $codec->encode($self);
}

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


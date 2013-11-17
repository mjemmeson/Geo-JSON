package Geo::JSON::Base;

# VERSION

# ABSTRACT: Base class for Geo::JSON objects

use Moo;

use Carp;

use Geo::JSON;

sub type {
    return ( ( ref $_[0] ) =~ m/::(\w+)$/ )[0];
}

=head1 DESCRIPTION

Base class for object representing Geojson types. Provides the C<to_json>
method.

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

1;


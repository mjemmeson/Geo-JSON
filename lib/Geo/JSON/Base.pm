package Geo::JSON::Base;

# VERSION

# ABSTRACT: Base class for Geo::JSON objects

use Moo;

use Carp;

use Geo::JSON;

use Types::Standard -types;

has type => (
    is       => 'ro',
    isa      => Str,
    default  => sub { ( ( ref $_[0] ) =~ m/::(\w+)$/ )[0] },
    required => 1,
);

=head1 DESCRIPTION

Base class for object representing Geojson types. Provides the C<to_json>
method.

=head1 METHODS

=head2 to_json

    $point->to_json();

    # or with custom JSON codec
    $point->to_json( $codec );

Returns JSON string representing this object.

=cut

sub to_json {
    my $self = shift;
    my $codec = shift || $Geo::JSON::json;
    return $codec->encode($self);
}

# used by JSON 'convert_blessed'
sub TO_JSON {
    return { type => $_[0]->type, %{ $_[0] } };
}

1;


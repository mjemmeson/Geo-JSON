package Geo::JSON::Role::ToJson;

# VERSION

# ABSTRACT: Moo::Role providing to_json() methods for a geojson object

use Moo::Role;

=head1 DESCRIPTION

Provides the C<to_json> method.

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


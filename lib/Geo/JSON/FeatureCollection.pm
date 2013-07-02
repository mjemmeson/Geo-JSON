package Geo::JSON::FeatureCollection;

# VERSION

use Moo;
extends 'Geo::JSON::Base';

use Carp;
use Types::Standard qw/ ArrayRef /;
use Geo::JSON::Types qw/ Feature /;
use Geo::JSON::Utils;

has features =>
    ( is => 'ro', isa => ArrayRef [Feature], required => 1 );

sub inflate {
    my ( $class, $args ) = @_;

    my $features = $args->{features} or croak "features missing";

    return $class->new(
        {   features => [ map { Geo::JSON::Utils::inflate($_) } @{$features} ]
        }
    );
}

1;


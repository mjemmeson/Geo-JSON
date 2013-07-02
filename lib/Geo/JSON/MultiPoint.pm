package Geo::JSON::MultiPoint;

use Moo;
extends 'Geo::JSON::Geometry';

use Geo::JSON::Point;
use Geo::JSON::Types qw/ Position Positions /;

has '+coordinates' => ( isa => Positions );

has points => ( is => 'lazy');

sub _build_points {
    my $self = shift;
    return [ map { Geo::JSON::Point->create( $_ ) } @{$self->coordinates} ];
}

1;


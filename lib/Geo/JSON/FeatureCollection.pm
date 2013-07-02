package Geo::JSON::FeatureCollection;

use Moo;
use Types::Standard qw/ ArrayRef /;
use Geo::JSON::Types qw/ Feature /;

has features =>
    ( is => 'ro', isa => ArrayRef [Feature], required => 1 );

1;


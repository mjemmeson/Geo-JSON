package Geo::JSON::Feature;

use Moo;
use Types::Standard qw/ Str Maybe HashRef /;
use Geo::JSON::Types qw/ Geometry /;

has id => ( is => 'ro', isa => Maybe [Str] );
has geometry =>
    ( is => 'ro', isa => Geometry, required => 1 );
has properties => ( is => 'ro', isa => Maybe [HashRef] );

1;


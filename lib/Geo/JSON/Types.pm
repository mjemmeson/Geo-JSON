package Geo::JSON::Types;

# VERSION

# ABSTRACT: Type::Tiny data types for Geo::JSON classes

use strict;
use warnings;

use Type::Library -base, -declare => qw/
    CRS
    Feature
    Geometry
    LinearRing
    LineString
    LineStrings
    Polygon
    Polygons
    Position
    Positions
    /;
use Type::Utils qw/ declare as where coerce from /;
use Types::Standard qw/ ArrayRef HashRef Maybe Num Object Tuple /;

use Geo::JSON::Utils qw/ compare_positions /;

use Class::Load qw/ load_class /;

declare CRS,      #
    as Object,    #
    where { $_ && $_->isa("Geo::JSON::CRS") };

declare Feature,    #
    as Object,      #
    where { $_ && $_->isa("Geo::JSON::Feature") };

declare Geometry,    #
    as Object,       #
    where { $_ && $_->isa("Geo::JSON::Geometry") };

declare Position,    #
    as Tuple [ Num, Num, Maybe [Num] ];

declare Positions,    #
    as ArrayRef [Position],    #
    where { @{$_} > 0 };

declare LineString,            #
    as Positions,              #
    where { @{$_} >= 2 };

declare LineStrings,           #
    as ArrayRef [LineString];

declare LinearRing,            #
    as LineString,             #
    where { @{$_} >= 4 && compare_positions( $_->[0], $_->[-1] ) };

declare Polygon,               #
    as ArrayRef [LinearRing];

declare Polygons,              #
    as ArrayRef [Polygon];

coerce Geometry, from HashRef, sub {
    my $args  = shift;
    my $class = 'Geo::JSON::' . delete $args->{type};
    load_class $class;
    $class->new($args);
};

=head1 TYPES EXPORTED

=over

=item *

Feature

=item *

Geometry

=item *

Position

=item *

Positions

=item *

LineString

=item *

LineStrings

=item *

LinearRing

=item *

Polygon

=item *

Polygons

=back

=cut

1;


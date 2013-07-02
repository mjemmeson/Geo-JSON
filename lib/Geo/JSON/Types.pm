package Geo::JSON::Types;

use strict;
use warnings;

use Type::Library -base, -declare => qw/
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
use Type::Utils;
use Types::Standard qw/ Tuple Num Maybe ArrayRef Object /;

use Geo::JSON::Utils qw/ compare_positions /;

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



1;


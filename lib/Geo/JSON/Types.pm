package Geo::JSON::Types;

# VERSION

# ABSTRACT: Type::Tiny data types for Geo::JSON classes

use strict;
use warnings;

BEGIN {
    use Type::Library -base, -declare => qw/
        CRS
        Feature
        Features
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
    use Types::Standard -types;

    use Geo::JSON::Utils qw/ compare_positions /;

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

    class_type CRS,      { class => 'Geo::JSON::CRS' };
    class_type Feature,  { class => 'Geo::JSON::Feature' };
    class_type Geometry, { class => 'Geo::JSON::Geometry' };

    coerce CRS, from HashRef, q{ "Geo::JSON::CRS"->new($_) };

    coerce Feature, from HashRef,
        q{ ("Geo::JSON::".(delete $_->{type}))->new($_) };

    coerce Geometry, from HashRef,
        q{ ("Geo::JSON::".(delete $_->{type}))->new($_) };

    declare Features, as ArrayRef [Feature], coercion => 1;

}

use Geo::JSON;
#  my $Geometry = declare Geometry,
#         as        Object,
#         where     {  ref $_ && $_->isa( 'Geo::JSON::Geometry')  };
#         inline_as { "$_ =~ /^[0-9]\$/ and $_ > 0" };

#      has age => (
#         is      => "rwp",
#         isa     => $PositiveInt,
#         coerce  => $PositiveInt->coercion,
#      );
#declare Geometry, as Object, where { ref $_ && $_->isa('Geo::JSON::Geometry') };

#use Geo::JSON::Point;
#coerce Geometry, from HashRef,
#    via sub { $_ = Geo::JSON::Point->new( $_ ) };

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


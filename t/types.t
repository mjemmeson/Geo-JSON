# types.t

use Test::Most;

use lib 't/lib';
use GeoJSONTests;

use Geo::JSON::Types qw/ Geometry /;

ok my $coerced
    = Geometry->coerce( { type => 'Point', coordinates => [ 1, 2 ] } ),
    "coerce Geometry from HashRef";

isa_ok $coerced, 'Geo::JSON::Point';
is_deeply $coerced->coordinates, [ 1, 2 ], "coordinates set ok";

done_testing();


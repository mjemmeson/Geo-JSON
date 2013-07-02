# json.t

use Test::Most;

use lib 't/lib';

use Geo::JSON;
use GeoJSONTests;

my @tests = (
    {   class => 'Point',
        args  => { coordinates => [ 1, 2 ] },
    },
    {   class => 'Point',
        args  => { coordinates => [ 1, 2, 3 ] },
    },
    {   class => 'MultiPoint',
        args  => { coordinates => [ [ 1, 2, 3 ], [ 4, 5, 6 ] ] },
    },
    {   class => 'LineString',
        args  => { coordinates => [ [ 1, 2, 3 ], [ 4, 5, 6 ] ] },
    },
    {   class => 'MultiLineString',
        args  => {
            coordinates => [
                [ [ 1, 2, 3 ], [ 4, 5, 6 ] ],    #
                [ [ 7, 8, 9 ], [ 0, 0, 0 ] ]
            ]
        },
    },
    {   class => 'Polygon',
        args  => {
            coordinates =>
                [ [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ], [ 7, 8 ], [ 1, 2 ] ] ],
        },
    },
);

foreach my $test (@tests) {

    note $test->{name} || $test->{class};

    my $json = GeoJSONTests->json( $test->{class}, $test->{args} );

    ok my $obj = Geo::JSON->from_json($json), "got object from json";

    isa_ok $obj, "Geo::JSON::" . $test->{class};

    is $obj->to_json, $json, "to_json ok";
}

done_testing();


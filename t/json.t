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
    {   name  => 'Polygon with bbox',
        class => 'Polygon',
        args  => {
            bbox => [ 1, 2, 7, 8 ],
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

note "CRS";

my @crs = (
    {   name  => "named CRS",
        class => 'CRS',
        args  => {
            type       => 'name',
            properties => { name => 'urn:ogc:def:crs:OGC:1.3:CRS84' }
        },
    },
    {   name  => "linked CRS",
        class => 'CRS',
        args  => {
            type       => 'link',
            properties => {
                href => 'http://example.com/crs/42',
                type => 'proj4'
            }
        }
    },
);

# note - never have to inflate CRS from JSON, they don't exist independently
foreach my $test (@crs) {

    note $test->{name} || $test->{class};

    my $json = GeoJSONTests->json( $test->{class}, $test->{args} );

    ok my $obj = GeoJSONTests->object( $test->{class}, $test->{args} ),
        "CRS object";

    is $obj->to_json, $json, "to_json ok";
}

note "Objects with CRS";

my $crs_obj = GeoJSONTests->object( 'CRS', $crs[0]->{args} );

foreach my $test (@tests) {

    note $test->{name} || $test->{class};

    my $json = GeoJSONTests->json( $test->{class},
        { %{ $test->{args} }, crs => $crs[0]->{args} } );

    ok my $obj = Geo::JSON->from_json($json), "got object from json";

    isa_ok $obj, "Geo::JSON::" . $test->{class};

    is $obj->to_json, $json, "to_json ok";
}

done_testing();


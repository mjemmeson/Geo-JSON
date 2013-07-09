# json.t

use Test::Most;

use lib 't/lib';

use Geo::JSON;
use GeoJSONTests;

my @tests = GeoJSONTests->tests;

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


# object.t

use Test::Most;

use lib 't/lib';
use GeoJSONTests;

foreach my $type ( GeoJSONTests->types ) {

    ok my $object = GeoJSONTests->object($type),
        "created $type with default args";

}

done_testing();


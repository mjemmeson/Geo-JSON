# feature.t

use Test::Most;

use lib 't/lib';
use GeoJSONTests;

use Geo::JSON::Feature;

my $pkg = 'Geo::JSON::Feature';

my %geometry_objects = map { $_ => GeoJSONTests->object($_) } qw/ Point /;

my %properties = ( property_1 => 'foo', property_2 => 'bar' );

while ( my ( $type, $object ) = each %geometry_objects ) {

    ok my $feature = $pkg->new( { geometry => $object } ), "new";

    isa_ok $feature, 'Geo::JSON::Feature';

    ok $feature
        = $pkg->new( { geometry => $object, properties => \%properties } ),
        "new, with properties";

    isa_ok $feature, 'Geo::JSON::Feature';

}

done_testing();


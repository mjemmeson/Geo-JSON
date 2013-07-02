# point.t

use Test::Most;

use Geo::JSON::Point;

my $pkg = 'Geo::JSON::Point';

dies_ok { $pkg->new() } "empty args";
dies_ok { $pkg->new( { coordinates => [] } ) } "empty arrayref";
dies_ok { $pkg->new( { coordinates => [1] } ) } "invalid coordinates";
dies_ok {
    $pkg->new( { coordinates => [ 1, 2, 3, 4 ] } );
}
"invalid coordinates";

ok my $point = $pkg->new( { coordinates => [ 1, 2 ] } ), "new";
ok $point = $pkg->new( { coordinates => [ 1, 2, 3 ] } ),
    "new - with altitude";

done_testing();


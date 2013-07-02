# multipoint.t

use Test::Most;

use Geo::JSON::MultiPoint;

my $pkg = 'Geo::JSON::MultiPoint';

dies_ok { $pkg->new() } "empty args";
dies_ok { $pkg->new( { coordinates => [] } ) } "empty arrayref";
dies_ok { $pkg->new( { coordinates => [1] } ) } "invalid coordinates";
dies_ok {
    $pkg->new( { coordinates => [ 1, 2, 3, 4 ] } );
}
"invalid coordinates";

ok my $multipoint = $pkg->new( { coordinates => [ [ 1, 2 ], [ 3, 4 ] ] } ),
    "new";
ok $multipoint = $pkg->new( { coordinates => [ [ 1, 2, 3 ], [ 4, 5, 6 ] ] } ),
    "new - with altitude";

done_testing();


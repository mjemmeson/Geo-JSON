# utils.t

use Test::Most;

use Geo::JSON::Utils qw/ compute_bbox /;

note "compute_bbox";

dies_ok { compute_bbox() } "dies ok with no args";

dies_ok { compute_bbox( [ 1, 2 ] ) } "dies ok with single position";

my @tests = (
    {   positions => [ [ 1, 2 ], [ 3, 4 ] ],
        bbox => [ 1, 2, 3, 4 ],
    },

    {   positions => [ [ 1, 4 ], [ 3, 2 ] ],
        bbox => [ 1, 2, 3, 4 ],
    },

    {   positions => [ [ -1, 4 ], [ 3, 2 ] ],
        bbox => [ -1, 2, 3, 4 ],
    },

    {   positions => [ [ 1, 4, 5 ], [ 3, 2, -10 ] ],
        bbox => [ 1, 2, -10, 3, 4, 5 ],
    },

    {   positions => [ [ 1, 4, 5 ], [ 3, 2, -10 ], [ 6, 6, 6 ] ],
        bbox => [ 1, 2, -10, 6, 6, 6 ],
    },
);

foreach my $test (@tests) {

    is_deeply compute_bbox( $test->{positions} ), $test->{bbox}, "bbox ok";
}

done_testing();


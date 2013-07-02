package Geo::JSON::Utils;

use strict;
use warnings;
use Carp;

use base 'Exporter';

our @EXPORT_OK = qw/ compare_positions /;

# TODO make better - need to ensure floating points are the same 
sub compare_positions {
    my ( $pos1, $pos2 ) = @_;

    foreach my $dim ( @{$pos1} ) {
        return 0
            if ( defined $pos1->{$dim} && !defined $pos2->{$dim} )
            || ( !defined $pos1->{$dim} && defined $pos2->{$dim} )
            || ( $pos1->{$dim} ne $pos2->{$dim} );
    }
    return 1;
}

sub inflate {
    my $data = shift;

    croak "inflate requires a hashref" unless ref $data eq 'HASH';

    my $type = delete $data->{type}
      or croak "Invalid JSON data: no type specified";

    my $geo_json_class = __PACKAGE__ . '::'. $type;

    eval "require $geo_json_class";
    croak "Unable to load '$geo_json_class'; $@" if $@;

    return $geo_json_class->inflate( $data );

}

1;


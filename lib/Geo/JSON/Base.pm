package Geo::JSON::Base;

# VERSION

# ABSTRACT: Base class for Geo::JSON objects

use Moo;

use Carp;
use Types::Standard qw/ Maybe /;

use Geo::JSON;
use Geo::JSON::Types -types;

has crs => ( is => 'ro', isa => Maybe[CRS], coerce => CRS->coercion );

sub type {
    return ( ( ref $_[0] ) =~ m/::(\w+)$/ )[0];
}

sub to_json {
    return $Geo::JSON::json->encode(shift);
}

sub TO_JSON {
    my $self = $_[0];

    my %output = (
        type => $self->type,
        %{$self},
    );

    delete $output{crs}
        unless defined $output{crs};

    return \%output;
}


1;


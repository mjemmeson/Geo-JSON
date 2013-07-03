package Geo::JSON::Base;

# VERSION

# ABSTRACT: Base class for Geo::JSON objects

use Moo;

use Carp;
use JSON ();
use Types::Standard qw/ Maybe /;

use Geo::JSON::Types qw/ CRS /;

my $json = JSON->new->canonical(1)->pretty->utf8->convert_blessed(1);

has type => (
    is      => 'ro',
    default => sub { return ( ( ref $_[0] ) =~ m/::(\w+)$/ )[0] },
);

has crs => ( is => 'ro', isa => Maybe[CRS] );

sub inflate {
    my ( $class, $args ) = @_;

    croak "coordinates missing" unless $args->{coordinates};

    return $class->new( { coordinates => $args->{coordinates} } );
}

sub to_json {
    my ( $self ) = @_;

    return $json->encode($self);
}

sub TO_JSON {
    return { %{$_[0]} };
}

1;


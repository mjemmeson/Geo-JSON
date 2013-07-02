package Geo::JSON::Base;

# VERSION

use Moo;

use Carp;
use JSON ();

my $json = JSON->new->pretty->utf8->convert_blessed(1);

has type => (
    is      => 'ro',
    default => sub { return ( ( ref $_[0] ) =~ m/::(\w+)$/ )[0] },
);

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


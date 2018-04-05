package MyScript::Boo;
use Data::Dumper;

use parent 'Inherit::Dispatch::Command';

sub run {
    my ( $self, @args ) = @_;

    print Dumper $self;
    print Dumper \@args;

}

1;


=head1 NAME

MyScript::Boo

=cut


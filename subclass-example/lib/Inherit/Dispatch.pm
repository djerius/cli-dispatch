package Inherit::Dispatch;

use base 'CLI::Dispatch';

sub options {
    my $self = shift;
    [ $self->SUPER::options ];
}

sub get_options {
    my ( $self, $specs ) = @_;
    $self->SUPER::get_options( @$specs );
}


1;

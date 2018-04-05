package Inherit::Dispatch::Command;

use base 'CLI::Dispatch::Command';

sub dispatch_class { 'Inherit::Dispatch' }

sub options {
    my $self = shift;
    [ $self->SUPER::options ];
}

sub check {

    shift;
    print ">> @{[__PACKAGE__]} <<\n";
    return 1;
}

1;

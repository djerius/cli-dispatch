package Inherit::Dispatch::Help;

use base 'CLI::Dispatch::Help';

sub dispatch_class { 'Inherit::Dispatch' }

sub options {
    my $self = shift;
    [ $self->SUPER::options ];
}

sub output {

    my $self = shift;

    print ">> @{[__PACKAGE__]} <<\n";
    $self->SUPER::output( @_ );
}

1;

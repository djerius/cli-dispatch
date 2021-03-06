package CLIDTestClass::Multi::Help;

use strict;
use warnings;
use Test::Classy::Base;
use CLI::Dispatch;
use File::Spec;
use Try::Tiny;

sub list : Tests(6) {
  my $class = shift;

  $class->_command_list;
}

sub list_with_help_command : Tests(6) {
  my $class = shift;

  $class->_command_list(qw( help ));
}

sub help_of_missing_file : Tests(6) {
  my $class = shift;

  $class->_command_list(qw( help nothing ));
}

sub unknown_command : Tests(6) {
  my $class = shift;

  $class->_command_list(qw( unknown_command ));
}

sub pod_with_help_command : Tests(2) {
  my $class = shift;

  $class->_pod(qw( help simple ));
}

sub pod_with_help_option : Tests(2) {
  my $class = shift;

  $class->_pod(qw( simple --help ));
}

sub _command_list {
  my $class = shift;

  my $ret = $class->dispatch(@_);

  my %map = (
    dump_me => 'dump_me\s+- dump me',
    help    => 'help\s+-',
    install => 'install\s+- how to install',
    simple  => 'simple\s+- alternative text for simple command',
    args    => 'with_args\s+- args test',
    options => 'with_options\s+- option test',
  );

  foreach my $key ( keys %map ) {
    like $ret => qr/$map{$key}/, $class->message("has $key");
  }
}

sub _pod {
  my $class = shift;

  my $ret = $class->dispatch(@_);

  ok $ret =~ /simple manual/, $class->message('has description');
  ok $ret !~ /alternative text for simple command/, $class->message('brief description is removed');
}

sub dispatch {
  my $class = shift;

  local @ARGV = @_;
  local $SIG{__WARN__} = sub {};

  open my $null, '>', File::Spec->devnull;
  my $stdout = select($null);

  my $ret;
  try   { $ret = CLI::Dispatch->run(qw/CLIDTest::More CLIDTest::Single/) }
  catch { $ret = $_ || 'Obscure error' };

  select($stdout);

  return $ret;
}

1;

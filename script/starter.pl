#!/usr/bin/perl
use strict;
eval 'exec /usr/bin/perl -w -S $0 ${1+"$@"}' if 0;
our $VERSION = '0.0.1';
use Getopt::Long;
use Pod::Usage;

#use FindBin qw($Bin);
#use lib "$Bin/../lib", "$Bin/../fatlib;

# TODO move to App::Package::Starter
my ($project);
sub parse_options {
    my $help = @ARGV == 0;
    my %opt = (
        'help|?'      => \$help,
        'project|p=s' => \$project,
    );

    GetOptions(%opt);

    pod2usage(1) if $help;
    pod2usage(1) unless $project;
}


unless (caller) {
    parse_options();
    my $starter = App::Package::Starter->new( project_name => $project, );
    $starter->gen_package() or exit(1);
}

__END__

=head1 NAME

XXX - This program allows you to build XXX  package template easily

=head1 SYNOPSIS

    XXX [options]

Example:

    XXX --project MyProj

Options:


=head1 DESCRIPTION


=head1 AUTHOR


=head1 COPYRIGHT AND LICENSE

=cut



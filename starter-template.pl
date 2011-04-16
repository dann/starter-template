#!/usr/bin/env perl

eval 'exec /usr/bin/perl -w -S $0 ${1+"$@"}' if 0;

use strict;
use warnings;

our $VERSION = '0.0.1';

use Getopt::Long;
use Pod::Usage;

my $help = @ARGV == 0;
my ($project);
my %opt = (
    'help|?'      => \$help,
    'project|p=s' => \$project,
);

GetOptions(%opt);

pod2usage(1) if $help;
pod2usage(1) unless $project;

my $starter = Package::Starter->new(
    project_name => $project,
);

$starter->gen_package();

package Package::Starter;


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

use Data::Section::Simple qw(get_data_section);
use File::Spec;
use File::Basename;
use File::Path;
use IO::File;

our $VERSION = '0.01';

sub new {
    my ($class, %args) = @_;
    my $self = bless { 
        project_name => "MyLib",
        %args, 
    }, $class;
    return $self;
}

sub _mkdir {
    my ($self, $path) = @_;
    unless (-e $path && -d _) {
        mkdir($path, 0755)
            or die "Coundn't mkdir $path.";
    }
    print "Created directory: ";
    print $path, "\n";
    return $path;
}

sub _mkfile {
    my ($self, $path, $content) = @_;
    unless (-e $path && -f _) {
        File::Path::mkpath(dirname($path));
        my $fh = IO::File->new($path, "w")
            or die "Couldn't write file $path";
        $fh->print($content);
        $fh->close();
    }
    print "Created file     : ";
    print $path, "\n";
}

sub get_project_name {
    my ($self) = @_;
    return $self->{project_name};
}

sub get_package_name {
    my ($self) = @_;
    return lc $self->{project_name};
}

sub gen_package {
    my ($self) = @_;
    $self->gen_project_dir();
    $self->gen_files();
    $self->print_welcome_message();
}

sub gen_files {
    my $self = shift;
    my $all_files = get_data_section;
    foreach my $file_path (keys %{$all_files}) {
        next if $file_path =~ /^__/;
        my $project_file_path = $self->get_project_name() . "/" . $file_path;
        my $file_content = get_data_section($file_path); 
        $self->_mkfile($project_file_path, $file_content);
    }
}

sub print_welcome_message {
    my $self = shift;
    my $template = get_data_section('__welcome_message');
    printf($template, 
        $self->get_project_name()
    );
}

sub gen_project_dir {
    my $self = shift;
    my $path = File::Spec->catdir(File::Spec->curdir,
        $self->get_project_name());
    $self->_mkdir($path);
}

1;

__DATA__
@@ __welcome_message
==============================
Welcome Message !!!
==============================

@@ sample/test.js
function hoge() {

}

@@ README
test

@@ src/main/java/hoge.java
aaa

#!/usr/bin/perl
use strict;
use warnings;
use App::FatPacker ();
use File::Path;
use Cwd;

my $modules = [ split /\s+/, <<MODULES ];
Data/Section/Simple.pm
File/Path.pm
File/Basename.pm
Getopt/Long.pm
Pod/Usage.pm
App/Package/Starter.pm
MODULES

my $packer = App::FatPacker->new;
my @packlists = $packer->packlists_containing($modules);
$packer->packlists_to_tree(cwd . "/fatlib", \@packlists);

use Config;
rmtree("fatlib/$Config{archname}");

__END__


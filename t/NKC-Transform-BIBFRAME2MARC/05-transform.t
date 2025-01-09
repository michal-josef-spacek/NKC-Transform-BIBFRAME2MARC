use strict;
use warnings;

use File::Object;
use NKC::Transform::BIBFRAME2MARC;
use Perl6::Slurp qw(slurp);
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Data dir.
my $data_dir = File::Object->new->up->dir('data');

# Test.
my $obj = NKC::Transform::BIBFRAME2MARC->new;
my $ex1 = slurp($data_dir->file('ex1.bibframe')->s);
my $ret = $obj->transform($ex1);
ok($ret, 'Generated MARC file.');

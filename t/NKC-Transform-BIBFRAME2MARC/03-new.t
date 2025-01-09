use strict;
use warnings;

use NKC::Transform::BIBFRAME2MARC;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = NKC::Transform::BIBFRAME2MARC->new;
isa_ok($obj, 'NKC::Transform::BIBFRAME2MARC');

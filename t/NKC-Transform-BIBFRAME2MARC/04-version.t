use strict;
use warnings;

use NKC::Transform::BIBFRAME2MARC;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = NKC::Transform::BIBFRAME2MARC->new;
my $ret = $obj->version;
is($ret, '2.6', 'Get version (2.6).');

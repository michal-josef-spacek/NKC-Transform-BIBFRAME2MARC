use strict;
use warnings;

use NKC::Transform::BIBFRAME2MARC;
use Test::More 'tests' => 4;
use Test::NoWarnings;

# Test.
my $obj = NKC::Transform::BIBFRAME2MARC->new;
my $ret = $obj->version;
is($ret, '2.6.0', 'Get version (2.6.0).');

# Test.
$obj = NKC::Transform::BIBFRAME2MARC->new(
	'version' => '2.8.1',
);
$ret = $obj->version;
is($ret, '2.8.1', 'Get version (2.8.1).');

# Test.
$obj = NKC::Transform::BIBFRAME2MARC->new(
	'version' => '2.10.0',
);
$ret = $obj->version;
is($ret, '2.10.0', 'Get version (2.10.0).');

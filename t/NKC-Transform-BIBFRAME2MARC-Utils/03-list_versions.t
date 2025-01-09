use strict;
use warnings;

use NKC::Transform::BIBFRAME2MARC::Utils qw(list_versions);
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my @ret = list_versions();
is_deeply(
	\@ret,
	[
		'2.6.0',
		'2.7.0',
		'2.8.0',
		'2.8.1',
	],
	'Fetch list of versions.',
);

use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use NKC::Transform::BIBFRAME2MARC;
use Test::More 'tests' => 3;
use Test::NoWarnings;

# Test.
my $obj = NKC::Transform::BIBFRAME2MARC->new;
isa_ok($obj, 'NKC::Transform::BIBFRAME2MARC');

# Test.
eval {
	NKC::Transform::BIBFRAME2MARC->new(
		'xslt_transformation_file' => 'bad',
	);
};
is($EVAL_ERROR, "Cannot read XSLT file.\n",
	"Cannot read XSLT file.");
clean();

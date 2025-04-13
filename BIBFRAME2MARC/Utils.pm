package NKC::Transform::BIBFRAME2MARC::Utils;

use base qw(Exporter);
use strict;
use warnings;

use Error::Pure qw(err);
use File::Spec::Functions qw(catfile);
use File::Share ':all';
use Readonly;

Readonly::Array our @EXPORT_OK => qw(list_versions);

our $VERSION = 0.02;

sub list_versions {
	my $dir = shift;

	if (! defined $dir) {
		$dir = dist_dir('NKC-Transform-BIBFRAME2MARC');
	}

	opendir(my $dh, $dir) or err "Cannot open directory.";
	my @versions = sort map { -f catfile($dir, $_) && m/^bibframe2marc-(.+)\.xsl$/ms ? $1 : () } readdir($dh);
	closedir($dh);

	return @versions;
}

1;

package NKC::Transform::BIBFRAME2MARC;

use strict;
use warnings;

use Class::Utils qw(set_params);
use Error::Pure qw(err);
use File::Share ':all';
use XML::LibXML;
use XML::LibXSLT;

our $VERSION = 0.02;

sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Version of transformation.
	$self->{'version'} = '2.6.0';

	# XSLT transformation file.
	$self->{'xslt_transformation_file'} = undef;

	# Process parameters.
	set_params($self, @params);

	if (! defined $self->{'xslt_transformation_file'}) {
		if (! defined $self->{'version'}) {
			err "Parameter 'version' is undefined.";
		}
		$self->{'xslt_transformation_file'} = dist_file('NKC-Transform-BIBFRAME2MARC',
			'bibframe2marc-'.$self->{'version'}.'.xsl');
	}

	if (! -r $self->{'xslt_transformation_file'}) {
		err "Cannot read XSLT file.",
			'XSLT file', $self->{'xslt_transformation_file'},
		;
	}

	$self->{'_xml_parser'} = XML::LibXML->new;
	$self->{'_xslt'} = XML::LibXSLT->new;

	return $self;
}

sub version {
	my $self = shift;

	my $dom = $self->{'_xml_parser'}->load_xml('location' => $self->{'xslt_transformation_file'});

	my $version = $dom->findvalue('//xsl:variable[@name="vCurrentVersion"]');
	$version =~ s/\s*DLC\s+bibframe2marc\s*//ms;
	$version =~ s/^v//ms;

	return $version;
}

sub transform {
	my ($self, $bf_xml, @params) = @_;

	my $bf_xml_input = $self->{'_xml_parser'}->load_xml('string' => $bf_xml);
	my $style_doc = $self->{'_xml_parser'}->parse_file($self->{'xslt_transformation_file'});

	my $stylesheet = $self->{'_xslt'}->parse_stylesheet($style_doc);

	my $results = $stylesheet->transform($bf_xml_input, @params);

	return $stylesheet->output_string($results);
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

NKC::Transform::BIBFRAME2MARC - bibframe2marc transformation class.

=head1 SYNOPSIS

 use NKC::Transform::BIBFRAME2MARC;

 my $obj = NKC::Transform::BIBFRAME2MARC->new(%params);
 my $version = $obj->version;
 my $marc_xml = $obj->transform($bf_xml, @params);

=head1 METHODS

=head2 C<new>

 my $obj = NKC::Transform::BIBFRAME2MARC->new(%params);

Constructor.

=over 8

=item * C<version>

Transformation version.

Default value is '2.6.0'.

Default value is undef.

=item * C<xslt_transformation_file>

XSLT transformation file.

Default value is XSLT transformation file for '2.6.0' version.

=back

Returns instance of object.

=head2 C<version>

 my $version = $obj->version;

Get bibframe2marc transformation version which is set to object.

Returns qr{\d\.\d\.\d} version string.

=head2 C<transform>

 my $marc_xml = $obj->transform($bf_xml, @params);

Transform BIBFRAME to MARC.

Returns MARC XML string.

=head1 ERRORS

 new():
         Cannot read XSLT file.
                 XSLT file: %s
         Parameter 'version' is undefined.
         From Class::Utils::set_params():
                 Unknown parameter '%s'.

=head1 EXAMPLE

=for comment filename=get_version.pl

 use strict;
 use warnings;

 use NKC::Transform::BIBFRAME2MARC;

 # Object.
 my $obj = NKC::Transform::BIBFRAME2MARC->new;

 # Get version.
 my $version = $obj->version;

 # Print out.
 print $version."\n";

 # Output:
 # 2.6.0

=head1 DEPENDENCIES

L<Class::Utils>,
L<Error::Pure>,
L<File::Share>,
L<XML::LibXML>,
L<XML::LibXSLT>.

=head1 SEE ALSO

=over

=item L<NKC::Transform::MARC2BIBFRAME>

marc2bibframe transformation class.

=item L<NKC::Transform::MARC2RDA>

marc2rda transformation class.

=item L<NKC::Transform::BIBFRAME2MARC::Utils>

Utilities for bibframe2marc transformations.

=back

=head1 REPOSITORY

L<https://github.com/michal-josef-spacek/NKC-Transform-BIBFRAME2MARC>

=head1 AUTHOR

Michal Josef Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

© 2024-2025 Michal Josef Špaček

BSD 2-Clause License

=head1 VERSION

0.02

=cut

package NKC::Transform::BIBFRAME2MARC;

use strict;
use warnings;

use Class::Utils qw(set_params);
use File::Share ':all';
use XML::LibXML;
use XML::LibXSLT;

our $VERSION = 0.02;

sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# XSLT transformation file.
	$self->{'xslt_transformation_file'} = dist_file('NKC-Transform-BIBFRAME2MARC',
		'bibframe2marc.xsl');

	# Process parameters.
	set_params($self, @params);

	$self->{'_xml_parser'} = XML::LibXML->new;
	$self->{'_xslt'} = XML::LibXSLT->new;

	return $self;
}

sub version {
	return '2.6';
}

sub transform {
	my ($self, $marc_xml) = @_;

	my $marc_xml_input = $self->{'_xml_parser'}->load_xml('string' => $marc_xml);
	my $style_doc = $self->{'_xml_parser'}->parse_file($self->{'xslt_transformation_file'});

	my $stylesheet = $self->{'_xslt'}->parse_stylesheet($style_doc);

	my $results = $stylesheet->transform($marc_xml_input);

	return $stylesheet->output_string($results);
}

1;

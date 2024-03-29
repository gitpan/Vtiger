#!/usr/bin/perl -w -- 
# generated by wxGlade 0.6.3 on Fri Jan 21 14:32:40 2011
# To get wxPerl visit http://wxPerl.sourceforge.net/

use Wx 0.15 qw[:allclasses];
use strict;
package Vtiger::Wx::Editor;

use base qw(Wx::App);
use strict;

use Vtiger::Wx::ObjEditorFrame;

sub OnInit {
	my( $self ) = shift;

	Wx::InitAllImageHandlers();

	my $frame = Vtiger::Wx::ObjEditorFrame->new();

	$self->SetTopWindow($frame);
	$frame->Show(1);

	return 1;
}
# end of class Vtiger::Wx::Editor

package main;

unless(caller){
	my $objEditor = Vtiger::Wx::Editor->new();
	$objEditor->MainLoop();
}

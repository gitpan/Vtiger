use Wx 0.15 qw[:allclasses];
use strict;
package Vtiger::Wx::vtObjEditor;

use Wx qw[:everything];
use base qw(Wx::Frame);
use strict;

# begin wxGlade: ::dependencies
# end wxGlade

sub new {
	my( $self, $parent, $id, $title, $pos, $size, $style, $name ) = @_;
	$parent = undef              unless defined $parent;
	$id     = -1                 unless defined $id;
	$title  = ""                 unless defined $title;
	$pos    = wxDefaultPosition  unless defined $pos;
	$size   = wxDefaultSize      unless defined $size;
	$name   = ""                 unless defined $name;

# begin wxGlade: vtObjEditor::new

	$style = wxDEFAULT_FRAME_STYLE 
		unless defined $style;

	$self = $self->SUPER::new( $parent, $id, $title, $pos, $size, $style, $name );
	$self->{panel_1} = Wx::Panel->new($self, -1, wxDefaultPosition, wxDefaultSize, );
	$self->{panel_2} = Wx::Panel->new($self->{panel_1}, -1, wxDefaultPosition, wxDefaultSize, );
	$self->{panel_3} = Wx::Panel->new($self->{panel_1}, -1, wxDefaultPosition, wxDefaultSize, );
	$self->{panel_4} = Wx::Panel->new($self->{panel_1}, -1, wxDefaultPosition, wxDefaultSize, wxSUNKEN_BORDER|wxTAB_TRAVERSAL);
	$self->{label_1} = Wx::StaticText->new($self->{panel_4}, -1, "label_1", wxDefaultPosition, wxDefaultSize, );
	$self->{label_1_copy_1} = Wx::StaticText->new($self->{panel_3}, -1, "label_1", wxDefaultPosition, wxDefaultSize, );
	$self->{label_1_copy} = Wx::StaticText->new($self->{panel_2}, -1, "label_1", wxDefaultPosition, wxDefaultSize, );

	$self->__set_properties();
	$self->__do_layout();

# end wxGlade
	return $self;

}


sub __set_properties {
	my $self = shift;

# begin wxGlade: vtObjEditor::__set_properties

	$self->SetTitle("frame_1");

# end wxGlade
}

sub __do_layout {
	my $self = shift;

# begin wxGlade: vtObjEditor::__do_layout

	$self->{parentSizer} = Wx::BoxSizer->new(wxVERTICAL);
	$self->{sizer_1} = Wx::BoxSizer->new(wxVERTICAL);
	$self->{sizer_2_copy} = Wx::BoxSizer->new(wxHORIZONTAL);
	$self->{sizer_2_copy_1} = Wx::BoxSizer->new(wxHORIZONTAL);
	$self->{sizer_2} = Wx::BoxSizer->new(wxHORIZONTAL);
	$self->{sizer_2}->Add(20, 20, 0, 0, 0);
	$self->{sizer_2}->Add($self->{label_1}, 0, 0, 0);
	$self->{sizer_2}->Add(20, 20, 0, 0, 0);
	$self->{panel_4}->SetSizer($self->{sizer_2});
	$self->{sizer_1}->Add($self->{panel_4}, 1, wxALL|wxEXPAND|wxALIGN_CENTER_HORIZONTAL, 0);
	$self->{sizer_2_copy_1}->Add(20, 20, 0, 0, 0);
	$self->{sizer_2_copy_1}->Add($self->{label_1_copy_1}, 0, 0, 0);
	$self->{sizer_2_copy_1}->Add(20, 20, 0, 0, 0);
	$self->{panel_3}->SetSizer($self->{sizer_2_copy_1});
	$self->{sizer_1}->Add($self->{panel_3}, 1, wxEXPAND, 0);
	$self->{sizer_2_copy}->Add(20, 20, 0, 0, 0);
	$self->{sizer_2_copy}->Add($self->{label_1_copy}, 0, 0, 0);
	$self->{sizer_2_copy}->Add(20, 20, 0, 0, 0);
	$self->{panel_2}->SetSizer($self->{sizer_2_copy});
	$self->{sizer_1}->Add($self->{panel_2}, 0, wxEXPAND, 2);
	$self->{panel_1}->SetSizer($self->{sizer_1});
	$self->{parentSizer}->Add($self->{panel_1}, 1, wxEXPAND, 0);
	$self->SetSizer($self->{parentSizer});
	$self->{parentSizer}->Fit($self);
	$self->Layout();

# end wxGlade
}

# end of class vtObjEditor

1;


__END__


# Layout
##############################################
    my $mainsizer   = Wx::BoxSizer-> new ( wxVERTICAL );

    my $topsizer    = Wx::BoxSizer-> new ( wxHORIZONTAL );
    my $midsizer    = Wx::FlexGridSizer-> new ( 
        8, 4, 2, 2 );
    my $botsizer    = Wx::BoxSizer-> new ( wxHORIZONTAL );

# TOP
##############################################
    my $title = Wx::StaticText->new(
        $parent, -1, $type." editor", [-1, -1], [-1, -1]
    );
    $topsizer->Add($title, -1, wxSHAPED | wxALIGN_CENTER, 2);

# CONTENT
##############################################
    my $vtfield = [];
    my $wxfield = [];
    my $wxinput = [];
    my $wxsizer = [];
    my $i       = 0;
    foreach my $field (@{$description->{fields}}){

#print $field->{label}."\n#############################\n";
#use Data::Dumper;
#print Dumper $field->{label};
#print "#############################\n";

        $vtfield->[$i] = $field;
        $wxsizer->[$i] = Wx::BoxSizer-> new ( wxHORIZONTAL );
        
        # FIXME What control can I use?
        $wxinput->[$i] = Wx::TextCtrl->new(
            $parent, -1, $field->{value}, [-1, -1], [-1, -1]
        );
 
        $wxfield->[$i] = Wx::StaticText->new(
            $parent, -1, $field->{label}, [-1, -1], [-1, -1]
        );
        $wxsizer->[$i]->Add($wxfield->[$i] , 1, 0, 2);
        $wxsizer->[$i]->Add($wxinput->[$i] , 1, 0, 2);
        $midsizer->Add($wxsizer->[$i] , 1, 0, 2);
        $i++;
    }

# BOTTOM
##############################################
    my $button_save = Wx::Button->new( 
        $parent, -1, 'Save '.$type.$id, [-1, -1], [-1, -1]
    );
    $botsizer->Add($button_save , 1, 0, 2);
         
    $mainsizer->Add($topsizer , 1, 0, 2);         
    $mainsizer->Add($midsizer , 1, 0, 2);         
    $mainsizer->Add($botsizer , 1, 0, 2);         


    $parent->SetSizer( $mainsizer );
    $mainsizer->SetSizeHints( $parent );


use Wx 0.15 qw[:allclasses];
use strict;
use warnings;

package Vtiger::Wx::Editor;

=head1 NAME

Vtiger::Wx::Editor

=head1 DESCRIPTION

Vtiger::Wx::Editor presents a dialog editor for Vtiger objects.

Needs a descriptor and the object to edit. Above the object is $contact.

    my $contacts  = $vt->query($sessionName,
        "select * from Contacts where account_id = '3x20';"
    ); 
    (my $contact) = @$contacts[0];

    my $description = $vt->describe($sessionName,'Contacts');


To launch the editor do:

    use Wx;
    use Vtiger::Wx::Editor;

    my $objEdGui      = Vtiger::Wx::Editor->new( $description );
    my $contactEdited = $objEdGui->editObject($contact);

=cut

use Wx qw[:everything];
use Vtiger::Wx::ObjEditorFrame;


sub new {
	my( $class, 
            $description, 
            $parent, 
            $id, 
            $title, 
            $pos, 
            $size, 
            $style, 
            $name ) = @_;

	$parent = undef              unless defined $parent;
	$id     = -1                 unless defined $id;
	$title  = ""                 unless defined $title;
	$pos    = wxDefaultPosition  unless defined $pos;
	$size   = wxDefaultSize      unless defined $size;
	$name   = ""                 unless defined $name;

	$style = wxDEFAULT_FRAME_STYLE 
		unless defined $style;
	my $app = Wx::SimpleApp->new( 
                $parent, 
                $id, 
                $title, 
                $pos, 
                $size, 
                $style, 
                $name );
	my $frame = Vtiger::Wx::ObjEditorFrame->new($description);

        my $self = {};
        $self->{app}            = $app;
        $self->{frame}          = $frame;
        $self->{description}    = $description;
        $self->{object}         = {};	
        bless $self, $class;
}

sub editObject{
        my ($self, $object) = @_;
        $self->{object} = $object;

        $self->{frame}->loadObject($object);
        $self->{frame}->Show;
        $self->{app}->MainLoop;

        $self->{object} = $self->{frame}->getObject();
        return $self->{object};
}

# end of class Vtiger::Wx::Editor

1;

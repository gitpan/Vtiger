package Vtiger::Wx; 
use strict;
use warnings;
use Vtiger;
use Vtiger::Wx::Editor; 
#use Vtiger::Wx::Login; 
#use Vtiger::Wx::Search; 

our $VERSION = '0.01000';

sub new {
    my $class   = shift;
    my $frame   = shift;
    my $vt      = shift;
    my $session = shift;

    my $parent;

    my $self    = {
        'parent' => $parent,
        'vt'     => $vt,
        'session'=> $session,
    };
    bless $self, $class;
}

sub editObject{
    my $self   = shift;
    my $type   = shift;
    my $id     = shift;
    my $parent = $self->{'parent'};

# get object description
    my $description = 
       $self->{vt}->describe($self->{session}->{sessionName},$type);

    my $objEditpr = Vtiger::Wx::Editor->new($description);
    $objEditpr->MainLoop();
return 0;









}

1;

 __END__

# init engine
our $vt =  new Vtiger(VTIGER_URL);

# cached vars to improve performance
# this globals are used by WXPerl ( c++ ) routines
# we can handle that cached context at session time

our $vtsession;     # hash ref
our $session;       # session name
our @moduleTypes;


# context vars
# this vars will to be restarted at each transaction
# the main entity for this interface is the Project
# Other entities are the objects related

our @projectNames;              # 100 first retrieved project names
our @projectFields;             # field names for module Projects
our @projectDescription;        #
our %projectDetails;

our @objectFields;
our @objectDescription;
our %objectDetais;

our $journalReportHtml;

our $vterror;

# TT config
my $config = {
    INCLUDE_PATH =>'templates',
    EVAL_PERL =>1,
};

my $tt = Template->new ($config);


# do things
# glue functions
##############################################

sub getSession {
    my $username = USER_NAME;
    my $pin      = ACCESS_KEY;

    $vtsession  = $vt->getSession($username, $pin);
    $session    = $vtsession->{'sessionName'};
    return $session;
}

sub getProjectNames {
    my $session = shift;
    my $projects = [];

    local $SIG{'__DIE__'} =
    sub {
        $vterror =  'uh .. oh ... '. $_[0];
        push(@projectNames, "No Projects\n$vterror");
    };

    eval {$projects = $vt->query($session, "select projectname from Projects")};
    foreach my $project (@{$projects}) {
        push(@projectNames, $project-> {'name'});
    }

    if (!@projectNames) {
        push(@projectNames, 'No Projects');
    }
    return @projectNames;
}

sub getContacts {
    return $vt->query($session,"select * from Contacts");
}

sub getAccounts {
    return $vt->query($session,"select * from Accounts");;
}

sub getProjects {
    return $vt->query($session,"select * from Projects");
}

sub createProject {
    my $name = shift;
    print "Sessao: $session\n";
    my $newPrj;

    my $prjData = {
        'assigned_user_id'=> $vtsession->{'userId'},
        'projectname'            => $name
        };

    local $SIG{'__DIE__'} =
    sub {
        $vterror = 'uh .. oh ... '. $_[0];
        $projectDetails{'info'} = 'No Details';
        $projectDetails{'error'} = $vterror;
    };
    eval {
    $newPrj = $vt->create(
         $session->{'sessionName'},
         'Projects',
         $prjData
     )
    };
     %projectDetails = $newPrj;
}

sub createObject {
    my $module  = shift;
    my $objData = shift;
    #print "Sessao: $session\n";
    my $newObj;

    local $SIG{'__DIE__'} =
    sub {
        $vterror = 'uh .. oh ... '. $_[0];
        $objectDetails{'info'} = 'No Details';
        $objectDetails{'error'} = $vterror;
    };
    eval {
    $newObj = $vt->create(
         $vtsession->{'sessionName'},
         $module,
         $objData
     )
    };
     %objectDetails = $newObj;
}


=head1 loadProjectDetails

 %projectDetails = (
                       "projectname"             =>  "O projeto",
                       "startdate"               =>  localtime,
                       "targetenddate"           =>  "12345",
                       "actualenddate"           =>  "12345",
                       "projectstatus"           =>  "plan",
                       "projecttype"             =>  "",
                       "linktoaccountscontacts"  =>  "Inez Oliveira",
                       "assigned_user_id"        =>  "1",
                       "project_no"              =>  "123",
                       "targetbudget"            =>  "300",
                       "projecturl"              =>  "http://www.ffff.com",
                       "projectpriority"         =>  "urgent",
                       "progress"                =>  "plan",
                       "createdtime"             =>  "123456",
                       "modifiedtime"            =>  "123456",
                       "description"             =>  "bla bla bla",
                       "id"                      =>  "0",
                   );

=cut


sub loadProjectDetails {
    my $projectId = shift;
    print "Sessao: $session\n";

    local $SIG{'__DIE__'} =
    sub {
        $vterror = 'uh .. oh ... '. $_[0];
        $projectDetails{'info'} = 'No Details';
        $projectDetails{'error'} = $vterror;
    };
    eval { %projectDetails = $vt->retrieve($session, $projectId)};
}

sub loadOjectDetails {
    my $objId = shift;
    #print "Sessao: $session\n";

    local $SIG{'__DIE__'} =
    sub {
        $vterror = 'uh .. oh ... '. $_[0];
        $objectDetails{'info'} = 'No Details';
        $objectDetails{'error'} = $vterror;
    };
    eval { %objectDetails = $vt->retrieve($session, $objId)};
}


sub listModules {
    my $sessionId = shift;
    my $res = $vt->listModules($sessionId);
    return $res->{types};
}

sub getObjectFields{
    my $objectName = shift;
    my $fields = $vt->describe($session, $objectName)->{'fields'};
    foreach my $field (@$fields){push @objectFields, $field->{'label'};}
}

sub getFieldProperies{
}

sub describeObject {
    getObjectFields('Projects');
}

sub describeProject {
    getObjectFields('Projects');
}

# html & report functions
#################################################
sub loadJournal {
    my $events;
    #eval {$events = $vt->query($session->{'sessionName'}, "select * from Events")};
    $events = $vt->query($session, "select * from Events;");
    my $vars = {
        'url'   => '/',
        'events' => $events};

use Data::Dumper;
print Dumper $events;

    my $input = 'journal.html';
    my $output = '';

    $tt->process ($input, $vars, \$output)
    || die $tt->error (), "\n";

    $journalReportHtml = $output;
}

1;
#END
####################################################

use strict;
use warnings;
use lib 'lib';
#use Test::More tests => 2;                      # last test to print
use Test::More  skip_all => "Can't test vtiger server";


#my $number_of_tests_run = 0;

use Vtiger::Wx;


my $url      = 'http://127.0.0.1/vtiger/webservice.php';
my $vt       = new Vtiger($url);
my $username = 'admin';
my $pin      = 'xBNhY4gLb9lnp2k2';

my $parent   = undef;


my $session  = $vt->getSession($username, $pin);



####################################
ok($session, 'Ok session '.$session->{'sessionName'});
#$number_of_tests_run++;

#my newContact = $gui->createObject('Contatos');

my $contacts  = $vt->query($session->{'sessionName'},"select * from Contacts where account_id = '3x20';"); 
##############################################################
(my $contact) = @$contacts[0];
is('Smith', $contact->{'lastname'}, 'Achou o Smith');

#my $retrievedContact = 
#  $vt->retrieve($session->{'sessionName'}, $contact->{id});

my $type = 'Contacts';
my $description = $vt->describe($session->{sessionName},$type);

my $objEdGui      = Vtiger::Wx::Editor->new( $description, $parent );

#my $contactEdited = $objEdGui->editObject($retrievedContact);

#print "########################\n";
#use Data::Dumper;
#print Dumper $contact;
my $contactEdited = $objEdGui->editObject($contact);

#use Data::Dumper;
#print Dumper $contactEdited;

#my findContact = $gui2->searchObject('Contatos');

#done_testing( $number_of_tests_run );

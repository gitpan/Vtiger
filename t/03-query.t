#
#===============================================================================
#
#         FILE:  03-query.t
#
#  DESCRIPTION:  vtiger query and other things
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Ricardo Filipo (rf), ticardo.filipo@gmail.com
#      COMPANY:  Mito-Lógica design e soluções de comunicação ltda
#      VERSION:  1.0
#      CREATED:  16-01-2011 09:11:27
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use lib 'lib';
#use Test::More tests => 2;                      # last test to print
use Test::More skip_all => "Can't test vtiger server";

#my $number_of_tests_run = 0;

use Vtiger;


my $url      = 'http://127.0.0.1/vtiger/webservice.php';
my $vt       = new Vtiger($url);
my $username = 'admin';
my $pin      = 'xBNhY4gLb9lnp2k2';

my $session  = $vt->getSession($username, $pin);

####################################
ok($session, 'Ok session '.$session->{'sessionName'});
#$number_of_tests_run++;

my $contacts  = $vt->query($session->{'sessionName'},"select * from Contacts;"); 
##############################################################
ok($contacts, 'Ok query'.$contacts);


#done_testing( $number_of_tests_run );

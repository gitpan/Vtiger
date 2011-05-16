use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Vtiger',
    license             => 'perl',
    dist_author         => q{Monsenhor <monsenhor@cpan.org>},
    dist_version_from   => 'lib/Vtiger.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Vtiger-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();

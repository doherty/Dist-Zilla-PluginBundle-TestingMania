use strict;
use warnings;
use Test::More 0.88 tests => 5;
use autodie;
use Test::DZil;
use Moose::Autobox;

subtest 'default' => sub {
    plan tests => 2;

    my $tzil = Builder->from_config(
        { dist_root => 'corpus/dist/DZT-Sample' },
        { add_files => {
                'source/dist.ini' => simple_ini(
                    'GatherDir',
                    'MetaYAML',
                    'MetaJSON',
                    '@TestingMania'
                ),
                'source/lib/DZT/Sample.pm' => '',
            }
        },
    );
    $tzil->build;

    my @tests = map $_->name =~ m{^t/} ? $_->name : (), $tzil->files->flatten;
    is_filelist(\@tests, [qw(t/00-compile.t)],
        'tests are all there') or diag explain \@tests;

    my @xtests = map $_->name =~ m{^xt/} ? $_->name : (), $tzil->files->flatten;
    is_filelist(\@xtests, [qw(          xt/author/critic.t              xt/author/test-eol.t
            xt/release/kwalitee.t       xt/release/unused-vars.t        xt/release/minimum-version.t
            xt/release/dist-manifest.t  xt/release/portability.t        xt/release/pod-coverage.t
            xt/release/test-version.t   xt/release/cpan-changes.t       xt/release/synopsis.t
            xt/release/no-tabs.t        xt/release/pod-linkcheck.t      xt/release/pod-syntax.t
            xt/release/distmeta.t       xt/release/meta-json.t          xt/release/mojibake.t)],
        'xtests are all there') or diag explain \@xtests;
};

subtest 'enable' => sub {
    plan skip_all => 'all tests are on by default now';#tests => 1;

    my $tzil = Builder->from_config(
        { dist_root => 'corpus/dist/DZT' },
        { add_files => {
                'source/dist.ini' => simple_ini(
                    'GatherDir',
                    'MetaYAML',
                    'MetaJSON',
                    ['@TestingMania' => {enable => 'ConsistentVersionTest'} ],
                ),
                'source/lib/DZT/Sample.pm' => '',
            }
        }
    );
    $tzil->build;

    my $has_consistentversiontest = grep $_->name eq 'xt/release/consistent-version.t', $tzil->files->flatten;
    ok $has_consistentversiontest, 'ConsistentVersionTest added itself';
    diag explain map { $_->name } $tzil->files->flatten;
};

subtest 'disable' => sub {
    plan tests => 2;

    my $tzil = Builder->from_config(
        { dist_root => 'corpus/dist/DZT' },
        { add_files => {
                'source/dist.ini' => simple_ini(
                    'GatherDir',
                    'MetaYAML',
                    'MetaJSON',
                    ['@TestingMania' => { disable => [qw(Test::EOL Test::NoTabs)] } ],
                ),
                'source/lib/DZT/Sample.pm' => '',
            }
        }
    );
    $tzil->build;

    my @files = map { $_->name } $tzil->files->flatten;
    my $has_eoltest = grep { $_ eq 'xt/author/test-eol.t' } @files;
    ok !$has_eoltest, 'EOLTests was disabled';

    my $has_notabstest = grep { $_ eq 'xt/release/no-tabs.t' } @files;
    ok !$has_notabstest, 'Test::NoTabs was disabled';
};

subtest 'back-compat' => sub {
    plan tests => 1;

    my $tzil = Builder->from_config(
        { dist_root => 'corpus/dist/DZT' },
        { add_files => {
                'source/dist.ini' => simple_ini(
                    'GatherDir',
                    'MetaYAML',
                    'MetaJSON',
                    ['@TestingMania' => { disable => [qw(NoTabsTests)] } ],
                ),
                'source/lib/DZT/Sample.pm' => '',
            }
        }
    );
    $tzil->build;

    my @files = map { $_->name } $tzil->files->flatten;
    my $has_notabstest = grep { $_ eq 'xt/release/no-tabs.t' } @files;
    ok !$has_notabstest, 'Test::NoTabs was disabled by using the back-compat name (NoTabsTests)';
};

subtest 'nonexistent test' => sub {
    my $tzil = Builder->from_config(
        { dist_root => 'corpus/dist/DZT' },
        {
            add_files => {
                'source/dist.ini' => simple_ini(
                    ('GatherDir', 'MetaYAML', 'MetaJSON', ['@TestingMania' => { disable => 'Nonexistent', enable => 'Test::EOL' }])
                ),
                'source/lib/DZT/Sample.pm' => '',
            },
        },
    );
    $tzil->build;

    my @tests = map $_->name =~ m{^x?t/} ? $_->name : (), $tzil->files->flatten;
    my $has_eoltest = grep { $_ eq 'xt/author/test-eol.t' } @tests;
    ok $has_eoltest, 'EOLTests enbled';

    is_filelist \@tests, [qw(           t/00-compile.t                  xt/author/critic.t
        xt/author/test-eol.t            xt/release/test-version.t       xt/release/pod-coverage.t
        xt/release/synopsis.t           xt/release/dist-manifest.t      xt/release/meta-json.t
        xt/release/cpan-changes.t       xt/release/distmeta.t           xt/release/unused-vars.t
        xt/release/kwalitee.t           xt/release/no-tabs.t            xt/release/minimum-version.t
        xt/release/portability.t        xt/release/pod-linkcheck.t      xt/release/pod-syntax.t
        xt/release/mojibake.t
    )];
};

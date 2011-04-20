use strict;
use warnings;
use Test::More 0.88 tests => 3;
use autodie;
use Test::DZil;
use Moose::Autobox;

subtest 'default' => sub {
    plan tests => 2;

    my $tzil = Builder->from_config(
        { dist_root => 'corpus/dist/DZT' },
        {
            add_files => {
                'source/dist.ini' => simple_ini(
                    ('GatherDir', 'MetaYAML', 'MetaJSON', '@TestingMania')
                ),
            },
        },
    );
    $tzil->build;

    my @tests = map $_->name =~ m{^t/} ? $_->name : (), $tzil->files->flatten;
    @tests = sort @tests;
    is_deeply(\@tests, [sort qw(t/00-compile.t)], 'tests are all there') or diag explain \@tests;

    my @xtests = map $_->name =~ m{^xt/} ? $_->name : (), $tzil->files->flatten;
    @xtests = sort @xtests;
    is_deeply(\@xtests, [sort qw(       xt/author/critic.t              xt/release/kwalitee.t
            xt/release/unused-vars.t    xt/release/minimum-version.t    xt/release/dist-manifest.t
            xt/release/portability.t    xt/release/pod-coverage.t       xt/release/has-version.t
            xt/release/eol.t            xt/release/cpan-changes.t       xt/release/synopsis.t
            xt/release/no-tabs.t        xt/release/pod-linkcheck.t      xt/release/pod-syntax.t
            xt/release/distmeta.t       xt/release/meta-json.t)],
        'xtests are all there') or diag explain \@xtests;
};

subtest 'enable' => sub {
    plan tests => 1;

    my $tzil = Builder->from_config(
        { dist_root => 'corpus/dist/DZT' },
        {
            add_files => {
                'source/dist.ini' => simple_ini(
                    ('GatherDir', 'MetaYAML', 'MetaJSON', ['@TestingMania' => {enable => 'ConsistentVersionTest'} ])
                ),
            },
        },
    );
    $tzil->build;

    my $has_consistentversiontest = grep $_->name eq 'xt/release/consistent-version.t', $tzil->files->flatten;
    ok($has_consistentversiontest, 'ConsistentVersionTest added itself');
};

subtest 'disable' => sub {
    plan tests => 2;

    my $tzil = Builder->from_config(
        { dist_root => 'corpus/dist/DZT' },
        {
            add_files => {
                'source/dist.ini' => simple_ini(
                    ('GatherDir', 'MetaYAML', 'MetaJSON', ['@TestingMania' => {disable => 'EOLTests,NoTabsTests'} ])
                ),
            },
        },
    );
    $tzil->build;

    my $has_eoltest = grep $_->name eq 'xt/release/eol.t', $tzil->files->flatten;
    ok(!$has_eoltest, 'EOLTests was disabled');

    my $has_notabstest = grep $_->name eq 'xt/release/no-tabs.t', $tzil->files->flatten;
    ok(!$has_notabstest, 'NoTabsTests was disabled');
};

END { # Remove (empty) dir created by building the dists
    require File::Path;
    File::Path::rmtree('tmp');
}

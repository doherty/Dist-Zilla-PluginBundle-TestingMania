package Dist::Zilla::PluginBundle::TestingMania;
# ABSTRACT: test your dist with every testing plugin conceivable
use strict;
use warnings;
use 5.010001; # We use the smart match operator
# VERSION


use Moose;
use namespace::autoclean;
with 'Dist::Zilla::Role::PluginBundle::Easy';

=head1 SYNOPSIS

In F<dist.ini>:

    [@TestingMania]

=for test_synopsis
1;
__END__

=head1 DESCRIPTION

This plugin bundle collects all the testing plugins for L<Dist::Zilla> which
exist (and are not deprecated). This is for the most paranoid people who
want to test their dist seven ways to Sunday.

Simply add the following near the end of F<dist.ini>:

    [@TestingMania]

=head2 Testing plugins

=over 4

=item *

L<Dist::Zilla::Plugin::Test::Compile>, which performs tests to syntax check your
dist.

=item *

L<Dist::Zilla::Plugin::Test::Perl::Critic>, which checks your code against best
practices. See L<Test::Perl::Critic> and L<Perl::Critic> for details.

You can set a perlcritic config file:

    [@TestingMania]
    critic_config = perlcriticrc

=item *

L<Dist::Zilla::Plugin::Test::DistManifest>, which tests F<MANIFEST> for
correctness. See L<Test::DistManifest> for details.

=item *

L<Dist::Zilla::Plugin::Test::EOL>, which ensures the correct line endings are
used (and also checks for trailing whitespace). See L<Test::EOL> for details.

=item *

L<Dist::Zilla::Plugin::Test::Version>, which tests that your dist has
version numbers, and that they are valid. See L<Test::Version> for exactly
what that means.

=item *

L<Dist::Zilla::Plugin::Test::Kwalitee>, which performs some basic kwalitee checks.
I<Kwalitee> is an automatically-measurable guage of how good your software is.
It bears only a B<superficial> resemblance to the human-measurable guage of
actual quality. See L<Test::Kwalitee> for a description of the tests.

=item *

L<Dist::Zilla::Plugin::MetaTests>, which performs some extra tests on
F<META.yml>. See L<Test::CPAN::Meta> for what that means.

=item *

L<Dist::Zilla::Plugin::Test::CPAN::Meta::JSON>, which performs some extra tests
on F<META.json>, if it exists. See L<Test::CPAN::Meta::JSON> for what that
means.

=item *

L<Dist::Zilla::Plugin::Test::MinimumVersion>, which tests for the minimum
required version of perl. See L<Test::MinimumVersion> for details, including
limitations.

=item *

L<Dist::Zilla::Plugin::MojibakeTests>, which tests for the correct
source/documentation character encoding.

=item *

L<Dist::Zilla::Plugin::NoTabsTests>, which ensures you don't use I<The Evil
Character>. See L<Test::NoTabs> for details. If you wish to exclude this plugin,
see L</"Disabling Tests">.

=item *

L<Dist::Zilla::Plugin::PodCoverageTests>, which checks that you have Pod
documentation for the things you should have it for. See L<Test::Pod::Coverage>
for what that means.

=item *

L<Dist::Zilla::Plugin::PodSyntaxTests>, which checks that your Pod is
well-formed. See L<Test::Pod> and L<perlpod> for details.

=item *

L<Dist::Zilla::Plugin::Test::Portability>, which performs some basic tests to
ensure portability of file names. See L<Test::Portability::Files> for what
that means.

=item *

L<Dist::Zilla::Plugin::Test::Synopsis>, which does syntax checking on the code
from your SYNOPSIS section. See L<Test::Synopsis> for details and limitations.

=item *

L<Dist::Zilla::Plugin::Test::UnusedVars>, which checks your dist for unused
variables. See L<Test::Vars> for details.

=item *

L<Dist::Zilla::Plugin::Test::Pod::LinkCheck>, which checks the links in your POD.
See L<Test::Pod::LinkCheck> for details.

=item *

L<Dist::Zilla::Plugin::Test::CPAN::Changes>, which checks your changelog for
conformance with L<CPAN::Changes::Spec>. See L<Test::CPAN::Changes> for details.

Set C<changelog> in F<dist.ini> if you don't use F<Changes>:

    [@TestingMania]
    changelog = CHANGELOG

=back

=head2 Disabling Tests

To exclude a testing plugin, give a comma-separated list in F<dist.ini>:

    [@TestingMania]
    disable = Test::DistManifest,Test::Kwalitee

=head2 Enabling Tests

This pluginbundle may have some testing plugins that aren't
enabled by default. This option allows you to turn them on. Attempting to add
plugins which are not listed above will have I<no effect>.

To enable a testing plugin, give a comma-separated list in F<dist.ini>:

    [@TestingMania]
    enable = Test::Compile

=for Pod::Coverage configure

=cut

sub configure {
    my $self = shift;

    my %plugins = (
        'Test::CPAN::Changes'   => $self->config_slice('changelog'),
        'Test::CPAN::Meta::JSON'=> 1, # prunes itself if META.json isn't there
        'Test::Pod::LinkCheck'  => 1,
        'Test::Version'         => 1,
        'Test::Compile'         => 1,
        'Test::Perl::Critic'    => $self->config_slice('critic_config'),
        'Test::DistManifest'    => 1,
        'Test::EOL'             => 1,
        'Test::Kwalitee'        => 1,
        MetaTests               => 1, # should only be loaded if MetaYAML is loaded, or the file exists in the dist
        'Test::MinimumVersion'  => 1,
        MojibakeTests           => 1,
        NoTabsTests             => 1,
        PodCoverageTests        => 1,
        PodSyntaxTests          => 1,
        'Test::Portability'     => 1,
        'Test::Synopsis'        => 1,
        'Test::UnusedVars'      => 1,
    );
    my @include = ();

    my @disable = $self->payload->{disable}
        ? split(/, ?/, $self->payload->{disable})
        : ();
    foreach my $plugin (keys %plugins) {
        next if (                   # Skip...
            $plugin ~~ @disable or  # plugins they asked to skip
            $plugin ~~ @include or  # plugins we already included
            !$plugins{$plugin}      # plugins in the list, but which we don't want to add
        );
        push(@include, ref $plugins{$plugin}
            ? [ $plugin => $plugins{$plugin} ]
            : $plugin);
    }

    my @enable = $self->payload->{enable}
        ? split(/, ?/, $self->payload->{enable})
        : ();
    foreach my $plugin (@enable) {
        next unless $plugin ~~ %plugins; # Skip the plugin unless it is in the list of actual testing plugins
        push(@include, $plugin) unless ($plugin ~~ @include or $plugin ~~ @disable);
    }

    $self->add_plugins(@include);
}

__PACKAGE__->meta->make_immutable();

no Moose;

1;

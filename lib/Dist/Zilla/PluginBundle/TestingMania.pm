use 5.0100; # We use the smart match operator
use strict;
use warnings;
package Dist::Zilla::PluginBundle::TestingMania;
# ABSTRACT: test your dist with every testing plugin conceivable

=head1 DESCRIPTION

This plugin bundle collects all the testing plugins for L<Dist::Zilla> which
exist (and are not deprecated). This is for the most paranoid people who
want to test their dist seven ways to Sunday.

Simply add the following near the end of F<dist.ini>:

    [@TestingMania]

It includes the most recent version (as of release time) of the following
plugins, in their default configuration. Note that not all the plugins
are actually I<used> by default.

=head2 Testing plugins

=over 4

=item *

L<Dist::Zilla::Plugin::ApacheTest>, which builds a Makefile.PL that uses
L<ExtUtils::MakeMaker> with L<Apache::Test>. This is not enabled by default;
see L</"Adding tests">.

=item *

L<Dist::Zilla::Plugin::CheckChangesTests>, which checks your F<Changes> file
for correctness. See L<Test::CheckChanges> for what that means. This is not
enabled by default; see L</"Adding tests">.

=item *

L<Dist::Zilla::Plugin::CompileTests>, which performs tests to syntax check your
dist.

=item *

L<Dist::Zilla::Plugin::ConsistentVersionTest>, which tests that all modules in
the dist have the same version. See L<Test::ConsistentVersion> for details. This
is not enabled by default; see L</"Adding tests">.

=item *

L<Dist::Zilla::Plugin::CriticTests>, which checks your code against best practices.
See L<Perl::Critic> for details.

=item *

L<Dist::Zilla::Plugin::DistManifestTests>, which tests F<MANIFEST> for correctness.
See L<Test::DistManifest> for details.

=item *

L<Dist::Zilla::Plugin::EOLTests>, which ensures the correct line endings are used
(and also checks for trailing whitespace). See L<Test::EOL> for details.

=item *

L<Dist::Zilla::Plugin::HasVersionTests>, which tests that your dist has version
numbers. See L<Test::HasVersion> for what that means.

=item *

L<Dist::Zilla::Plugin::KwaliteeTests>, which performs some basic kwalitee checks.
I<Kwalitee> is an automatically-measurable guage of how good your software is. It
bears only a B<superficial> resemblance to the human-measurable guage of actual
quality. See L<Test::Kwalitee> for a description of the tests.

=item *

L<Dist::Zilla::Plugin::MetaTests>, which performs some extra tests on F<META.yml>.
See L<Test::CPAN::Meta> for what that means.

=item *

L<Dist::Zilla::Plugin::MinimumVersionTests>, which tests for the minimum required
version of perl. See L<Test::MinimumVersion> for details, including limitations.

=item *

L<Dist::Zilla::Plugin::NoTabsTests>, which ensures you don't use I<The Evil Character>.
See L<Test::NoTabs> for details. If you wish to exclude this plugin, see L</"Excluding Tests">.

=item *

L<Dist::Zilla::Plugin::PodCoverageTests>, which checks that you have Pod
documentation for the things you should have it for. See L<Test::Pod::Coverage>
for what that means.

=item *

L<Dist::Zilla::Plugin::PodSpellingTests>, which checks your L<Pod|perlpod> for
correct spelling. This is not enabled by default; see L</"Adding tests">.

=item *

L<Dist::Zilla::Plugin::PodSyntaxTests>, which checks that your Pod is well-formed.
See L<Test::Pod> and L<perlpod> for details.

=item *

L<Dist::Zilla::Plugin::PortabilityTests>, which performs some basic tests to
ensure portability of file names. See L<Test::Portability::Files> for what
that means.

=item *

L<Dist::Zilla::Plugin::ProgCriticTests>, which helps developers by gradually
enforcing coding standards. See L<Test::Perl::Critic::Progressive> for what
that means. This is not enabled by default; see L</"Adding tests">.

=item *

L<Dist::Zilla::Plugin::SynopsisTests>, which does syntax checking on the code
from your SYNOPSIS section. See L<Test::Synopsis> for details and limitations.

=item *

L<Dist::Zilla::Plugin::UnusedVarsTests>, which checks your dist for unused
variables. See L<Test::Vars> for details.

=back

=head2 Excluding rests

To exclude a testing plugin, give a comma-separated list in F<dist.ini>:

    [@TestingMania]
    skip = EOLTests,NoTabsTests

=head2 Adding tests

To add a testing plugin which is listed above, but not enabled by default,
give a comma-separated list in F<dist.ini>:

    [@TestingMania]
    add = ApacheTest,PodSpellingTests

Attempting to add plugins which are not listed above will have no effect.

=cut

use Moose;
with 'Dist::Zilla::Role::PluginBundle::Easy';

sub configure {
    my $self = shift;

    my %plugins = (
        ApacheTest              => 0, # Uncommonly needed
        CheckChangesTests       => 0, # Finnicky and annoying
        CompileTests            => 1,
        ConsistentVersionTest   => 0, # Finnicky and annoying
        CriticTests             => 1,
        DistManifestTests       => 1,
        EOLTests                => 1,
        HasVersionTests         => 1,
        KwaliteeTests           => 1,
        MetaTests               => 1,
        MinimumVersionTests     => 1,
        NoTabsTests             => 1,
        PodCoverageTests        => 1,
        PodSpellingTests        => 0, # Automated spelling tests are nerve-wracking
        PodSyntaxTests          => 1,
        PortabilityTests        => 1,
        ProgCriticTests         => 0, # Quite personal
        SynopsisTests           => 1,
        UnusedVarsTests         => 1,
    );
    my @include = ();

    my @skip = $self->payload->{skip} ? split(/, ?/, $self->payload->{skip}) : ();
    SKIP: foreach my $plugin (keys %plugins) {
        next SKIP if (              # Skip...
            $plugin ~~ @skip or     # plugins they asked to skip
            $plugin ~~ @include or  # plugins we already included
            !$plugins{$plugin}      # plugins in the list, but which we don't want to add
        );
        push(@include, $plugin);
    }

    my @add = $self->payload->{add} ? split(/, ?/, $self->payload->{add}) : ();
    ADD: foreach my $plugin (@add) {
        next ADD unless $plugin ~~ %plugins; # Skip the plugin unless it is in the list of actual testing plugins
        push(@include, $plugin) unless ($plugin ~~ @include or $plugin ~~ @skip);
    }

    $self->add_plugins(@include);
}

__PACKAGE__->meta->make_immutable();
no Moose;

1;

__END__

=begin Pod::Coverage

configure

=end Pod::Coverage

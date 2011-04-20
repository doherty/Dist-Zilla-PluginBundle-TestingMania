
use strict;
use warnings;

BEGIN { require 5.010001; }

use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'test your dist with every testing plugin conceivable',
  'AUTHOR' => 'Mike Doherty <doherty@cpan.org>',
  'BUILD_REQUIRES' => {
    'File::Find' => '0',
    'File::Path' => '0',
    'File::Temp' => '0',
    'Moose::Autobox' => '0',
    'Test::DZil' => '0',
    'Test::More' => '0.88',
    'autodie' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Dist-Zilla-PluginBundle-TestingMania',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Dist::Zilla::PluginBundle::TestingMania',
  'PREREQ_PM' => {
    'Dist::Zilla::Plugin::CompileTests' => '0',
    'Dist::Zilla::Plugin::ConsistentVersionTest' => '0',
    'Dist::Zilla::Plugin::CriticTests' => '1.102280',
    'Dist::Zilla::Plugin::DistManifestTests' => '0',
    'Dist::Zilla::Plugin::EOLTests' => '0.02',
    'Dist::Zilla::Plugin::HasVersionTests' => '0',
    'Dist::Zilla::Plugin::KwaliteeTests' => '0',
    'Dist::Zilla::Plugin::MetaTests' => '0',
    'Dist::Zilla::Plugin::MinimumVersionTests' => '0',
    'Dist::Zilla::Plugin::NoTabsTests' => '0',
    'Dist::Zilla::Plugin::PodCoverageTests' => '0',
    'Dist::Zilla::Plugin::PodSyntaxTests' => '0',
    'Dist::Zilla::Plugin::PortabilityTests' => '0',
    'Dist::Zilla::Plugin::SynopsisTests' => '0',
    'Dist::Zilla::Plugin::Test::CPAN::Changes' => '0',
    'Dist::Zilla::Plugin::Test::CPAN::Meta::JSON' => '0.003',
    'Dist::Zilla::Plugin::Test::Pod::LinkCheck' => '0',
    'Dist::Zilla::Plugin::UnusedVarsTests' => '0',
    'Dist::Zilla::Role::PluginBundle::Easy' => '0',
    'Moose' => '0',
    'Pod::Coverage::TrustPod' => '0',
    'Test::CPAN::Meta' => '0',
    'Test::Perl::Critic' => '0'
  },
  'VERSION' => '0.010',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);





use strict;
use warnings;

BEGIN { require 5.0100; }

use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'test your dist with every testing plugin conceivable',
  'AUTHOR' => 'Mike Doherty <doherty@cpan.org>',
  'BUILD_REQUIRES' => {
    'File::Find' => '0',
    'File::Temp' => '0.22',
    'Test::More' => '0.98'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Dist-Zilla-PluginBundle-TestingMania',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Dist::Zilla::PluginBundle::TestingMania',
  'PREREQ_PM' => {
    'Dist::Zilla::Plugin::CheckChangesTests' => '1.100900',
    'Dist::Zilla::Plugin::CompileTests' => '1.110870',
    'Dist::Zilla::Plugin::ConsistentVersionTest' => '0.02',
    'Dist::Zilla::Plugin::CriticTests' => '1.102280',
    'Dist::Zilla::Plugin::DistManifestTests' => '1.101420',
    'Dist::Zilla::Plugin::EOLTests' => '0.02',
    'Dist::Zilla::Plugin::HasVersionTests' => '1.101420',
    'Dist::Zilla::Plugin::KwaliteeTests' => '1.101420',
    'Dist::Zilla::Plugin::MetaTests' => '4.200004',
    'Dist::Zilla::Plugin::MinimumVersionTests' => '1.101421',
    'Dist::Zilla::Plugin::NoTabsTests' => '0.01',
    'Dist::Zilla::Plugin::PodCoverageTests' => '4.200004',
    'Dist::Zilla::Plugin::PodSyntaxTests' => '4.200004',
    'Dist::Zilla::Plugin::PortabilityTests' => '1.101420',
    'Dist::Zilla::Plugin::ProgCriticTests' => '1.102520',
    'Dist::Zilla::Plugin::SynopsisTests' => '1.101420',
    'Dist::Zilla::Plugin::UnusedVarsTests' => '1.100860',
    'Dist::Zilla::Role::PluginBundle::Easy' => '4.200004',
    'Moose' => '1.24',
    'Pod::Coverage::TrustPod' => '0.092832',
    'Test::CPAN::Meta' => '0.18',
    'Test::Perl::Critic' => '1.02'
  },
  'VERSION' => '0.005',
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




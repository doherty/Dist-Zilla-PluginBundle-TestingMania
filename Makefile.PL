
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'test your dist with every testing plugin conceivable',
  'AUTHOR' => 'Mike Doherty <doherty@cpan.org>',
  'BUILD_REQUIRES' => {
    'File::Find' => '0',
    'File::Path' => '0',
    'File::Temp' => '0',
    'Moose::Autobox' => '0.11',
    'Test::DZil' => '4.200007',
    'Test::More' => '0.88',
    'autodie' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.30'
  },
  'DISTNAME' => 'Dist-Zilla-PluginBundle-TestingMania',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Dist::Zilla::PluginBundle::TestingMania',
  'PREREQ_PM' => {
    'Dist::Zilla::Plugin::CompileTests' => '1.110930',
    'Dist::Zilla::Plugin::CriticTests' => '1.102280',
    'Dist::Zilla::Plugin::DistManifestTests' => '1.101420',
    'Dist::Zilla::Plugin::EOLTests' => '0.02',
    'Dist::Zilla::Plugin::KwaliteeTests' => '1.101420',
    'Dist::Zilla::Plugin::MetaTests' => '4.200007',
    'Dist::Zilla::Plugin::MinimumVersionTests' => '1.101421',
    'Dist::Zilla::Plugin::MojibakeTests' => '0.3',
    'Dist::Zilla::Plugin::NoTabsTests' => '0.01',
    'Dist::Zilla::Plugin::PodCoverageTests' => '4.200007',
    'Dist::Zilla::Plugin::PodSyntaxTests' => '4.200007',
    'Dist::Zilla::Plugin::PortabilityTests' => '1.101420',
    'Dist::Zilla::Plugin::SynopsisTests' => '1.101420',
    'Dist::Zilla::Plugin::Test::CPAN::Changes' => '0.004',
    'Dist::Zilla::Plugin::Test::CPAN::Meta::JSON' => '0.003',
    'Dist::Zilla::Plugin::Test::Pod::LinkCheck' => '1.000',
    'Dist::Zilla::Plugin::Test::Version' => '0.001002',
    'Dist::Zilla::Plugin::UnusedVarsTests' => '1.100860',
    'Dist::Zilla::Role::PluginBundle::Easy' => '4.200007',
    'Moose' => '2.0007',
    'Pod::Coverage::TrustPod' => '0.100000',
    'Test::CPAN::Meta' => '0.18',
    'Test::Perl::Critic' => '1.02',
    'Test::Version' => '0.07'
  },
  'VERSION' => '0.012',
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




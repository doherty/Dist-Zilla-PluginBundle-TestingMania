
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "test your dist with every testing plugin conceivable",
  "AUTHOR" => "Mike Doherty <doherty\@cpan.org>",
  "BUILD_REQUIRES" => {
    "File::Find" => 0,
    "File::Path" => 0,
    "File::Temp" => 0,
    "Module::Build" => "0.3601",
    "Moose::Autobox" => "0.11",
    "Test::DZil" => "4.300000",
    "Test::More" => "0.88",
    "autodie" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30",
    "Module::Build" => "0.3601"
  },
  "DISTNAME" => "Dist-Zilla-PluginBundle-TestingMania",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Dist::Zilla::PluginBundle::TestingMania",
  "PREREQ_PM" => {
    "Dist::Zilla::Plugin::EOLTests" => "0.02",
    "Dist::Zilla::Plugin::MetaTests" => "4.300000",
    "Dist::Zilla::Plugin::MojibakeTests" => "0.3",
    "Dist::Zilla::Plugin::NoTabsTests" => "0.01",
    "Dist::Zilla::Plugin::PodCoverageTests" => "4.300000",
    "Dist::Zilla::Plugin::PodSyntaxTests" => "4.300000",
    "Dist::Zilla::Plugin::Test::CPAN::Changes" => "0.005",
    "Dist::Zilla::Plugin::Test::CPAN::Meta::JSON" => "0.003",
    "Dist::Zilla::Plugin::Test::Compile" => "1.112390",
    "Dist::Zilla::Plugin::Test::DistManifest" => "v2.0.0",
    "Dist::Zilla::Plugin::Test::Kwalitee" => "v2.0.0",
    "Dist::Zilla::Plugin::Test::MinimumVersion" => "v2.0.0",
    "Dist::Zilla::Plugin::Test::Perl::Critic" => "2.112410",
    "Dist::Zilla::Plugin::Test::Pod::LinkCheck" => "1.001",
    "Dist::Zilla::Plugin::Test::Portability" => "v2.0.0",
    "Dist::Zilla::Plugin::Test::Synopsis" => "v2.0.0",
    "Dist::Zilla::Plugin::Test::Version" => "0.001002",
    "Dist::Zilla::Plugin::UnusedVarsTests" => "1.100860",
    "Dist::Zilla::Role::PluginBundle::Easy" => "4.300000",
    "Moose" => "2.0204",
    "Pod::Coverage::TrustPod" => "0.100001",
    "Test::CPAN::Meta" => "0.18",
    "Test::Perl::Critic" => "1.02",
    "Test::Version" => "0.07",
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.013",
  "test" => {
    "TESTS" => "t/*.t"
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




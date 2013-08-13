
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.3601"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "test your dist with every testing plugin conceivable",
  "dist_author" => [
    "Mike Doherty <doherty\@cpan.org>"
  ],
  "dist_name" => "Dist-Zilla-PluginBundle-TestingMania",
  "dist_version" => "0.20",
  "license" => "perl",
  "module_name" => "Dist::Zilla::PluginBundle::TestingMania",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Dist::Zilla::Plugin::MetaTests" => 0,
    "Dist::Zilla::Plugin::MojibakeTests" => "0.2",
    "Dist::Zilla::Plugin::NoTabsTests" => "0.01",
    "Dist::Zilla::Plugin::PodCoverageTests" => 0,
    "Dist::Zilla::Plugin::PodSyntaxTests" => 0,
    "Dist::Zilla::Plugin::Test::CPAN::Changes" => "0.005",
    "Dist::Zilla::Plugin::Test::CPAN::Meta::JSON" => "0.003",
    "Dist::Zilla::Plugin::Test::Compile" => "1.112400",
    "Dist::Zilla::Plugin::Test::DistManifest" => "2.000001",
    "Dist::Zilla::Plugin::Test::EOL" => 0,
    "Dist::Zilla::Plugin::Test::Kwalitee" => "2.020000",
    "Dist::Zilla::Plugin::Test::MinimumVersion" => "2.000001",
    "Dist::Zilla::Plugin::Test::Perl::Critic" => "2.112410",
    "Dist::Zilla::Plugin::Test::Pod::LinkCheck" => "1.001",
    "Dist::Zilla::Plugin::Test::Portability" => "2.000001",
    "Dist::Zilla::Plugin::Test::Synopsis" => "2.000001",
    "Dist::Zilla::Plugin::Test::UnusedVars" => "2.000001",
    "Dist::Zilla::Plugin::Test::Version" => "0.001002",
    "Dist::Zilla::Role::PluginBundle::Easy" => 0,
    "JSON::PP" => "2.27103",
    "List::MoreUtils" => 0,
    "Moose" => 0,
    "Pod::Coverage::TrustPod" => 0,
    "Test::CPAN::Meta" => 0,
    "Test::Perl::Critic" => 0,
    "Test::Version" => "0.07",
    "namespace::autoclean" => 0,
    "perl" => "5.006",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => [],
  "test_requires" => {
    "Capture::Tiny" => 0,
    "Moose::Autobox" => 0,
    "Test::DZil" => 0,
    "Test::More" => "0.88",
    "autodie" => 0,
    "blib" => 0
  }
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  my $tr = delete $module_build_args{test_requires};
  my $br = $module_build_args{build_requires};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

my $build = Module::Build->new(%module_build_args);

$build->create_build_script;

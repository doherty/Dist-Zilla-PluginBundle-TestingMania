
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "File::Find" => 0,
    "File::Path" => 0,
    "File::Temp" => 0,
    "Module::Build" => "0.3601",
    "Moose::Autobox" => "0.11",
    "Test::DZil" => "4.300000",
    "Test::More" => "0.88",
    "autodie" => 0
  },
  "configure_requires" => {
    "ExtUtils::MakeMaker" => "6.30",
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "test your dist with every testing plugin conceivable",
  "dist_author" => [
    "Mike Doherty <doherty\@cpan.org>"
  ],
  "dist_name" => "Dist-Zilla-PluginBundle-TestingMania",
  "dist_version" => "0.013",
  "license" => "perl",
  "module_name" => "Dist::Zilla::PluginBundle::TestingMania",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Dist::Zilla::Plugin::DistManifestTests" => "1.101420",
    "Dist::Zilla::Plugin::EOLTests" => "0.02",
    "Dist::Zilla::Plugin::KwaliteeTests" => "1.101420",
    "Dist::Zilla::Plugin::MetaTests" => "4.300000",
    "Dist::Zilla::Plugin::MinimumVersionTests" => "1.101421",
    "Dist::Zilla::Plugin::MojibakeTests" => "0.3",
    "Dist::Zilla::Plugin::NoTabsTests" => "0.01",
    "Dist::Zilla::Plugin::PodCoverageTests" => "4.300000",
    "Dist::Zilla::Plugin::PodSyntaxTests" => "4.300000",
    "Dist::Zilla::Plugin::PortabilityTests" => "1.111840",
    "Dist::Zilla::Plugin::SynopsisTests" => "1.101420",
    "Dist::Zilla::Plugin::Test::CPAN::Changes" => "0.005",
    "Dist::Zilla::Plugin::Test::CPAN::Meta::JSON" => "0.003",
    "Dist::Zilla::Plugin::Test::Compile" => "1.112390",
    "Dist::Zilla::Plugin::Test::Perl::Critic" => "2.112410",
    "Dist::Zilla::Plugin::Test::Pod::LinkCheck" => "1.001",
    "Dist::Zilla::Plugin::Test::Version" => "0.001002",
    "Dist::Zilla::Plugin::UnusedVarsTests" => "1.100860",
    "Dist::Zilla::Role::PluginBundle::Easy" => "4.300000",
    "Moose" => "2.0204",
    "Pod::Coverage::TrustPod" => "0.100001",
    "Test::CPAN::Meta" => "0.18",
    "Test::Perl::Critic" => "1.02",
    "Test::Version" => "0.07",
    "perl" => "5.010001",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;

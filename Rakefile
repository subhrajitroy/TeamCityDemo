require 'albacore'
require 'semver'
require_relative 'versions'
require_relative 'assembly_info'


RELEASE_VERSION = SemVer.find.format '%M.%m.%p'


desc 'Updates the TeamCity build number to the current semantic version'
task :update_teamcity_build_number => :generate_versions do
  puts "##teamcity[buildNumber '#{ENV['SEMANTIC_VERSION']}']"
end

task :default => :build

task :build => [:update_teamcity_build_number,:compile,:package]

desc 'Compile solution'
build :compile => [:restore,:set_assembly_version] do |b|
  b.sln = 'StringTest/StringTest.sln'
  b.target = %w(Clean Rebuild)
  b.prop 'Configuration', 'Release'
  b.prop 'BuildInParallel', 'true'
end

desc 'restore all nugets as per the packages.config files'
nugets_restore :restore do |p|
  p.out = 'src/packages'
  p.exe = 'tools/nuget/NuGet.exe'
end


def define_versions(*args, &block)
  Rake::Task.define_task *args do
        config = DefineVersionsConfig.new
        yield config
        DefineVersionsTask.new(config).execute
      end
end


desc 'Uses the semantic version and TeamCity API to generate the next version number. Results are stored in ENV variable; SEMANTIC_VERSION,ASSEMBLY_INFO_VERSION,DM_VERSION'
define_versions :generate_versions do |c|
  c.teamcity_url = 'localhost:8081'
  c.build_configuration_name = 'Learnings_TeamcityDemo_Build'
  c.formal_version = RELEASE_VERSION
end

task :set_assembly_version => [:generate_versions] do
 assembly_info = AssemblyInfo.new build_version,"StringTest/StringTest/Properties/AssemblyInfo.cs"
 assembly_info.create
end

directory 'build/pkg'

desc 'package nugets - finds all projects and package them'
nugets_pack :package => ['build/pkg'] do |p|
  p.files   = FileList['**/*.{csproj}'].
    exclude(/test/)
  p.out     = 'build/pkg'
  p.exe     = 'tools/nuget/NuGet.exe'
  p.with_metadata do |m|
    m.description = 'A cool nuget'
    m.authors = 'sroy'
    m.version = build_version
  end
  
end

def build_version
 ENV['SEMANTIC_VERSION']
end



require 'albacore'
require 'semver'
require_relative 'versions'


RELEASE_VERSION = SemVer.find.format '%M.%m.%p'


desc 'Updates the TeamCity build number to the current semantic version'
task :update_teamcity_build_number  do
  puts "##teamcity[buildNumber '#{ENV['SEMANTIC_VERSION']}']"
end

task :default => [:generate_versions,:update_teamcity_build_number]

def define_versions(*args, &block)
  Rake::Task.define_task *args do
        config = DefineVersionsConfig.new
        yield config
        DefineVersionsTask.new(config).execute
      end
end


desc 'Uses the semantic version and TeamCity API to generate the next version number. Results are stored in ENV variable; SEMANTIC_VERSION,ASSEMBLY_INFO_VERSION,DM_VERSION'
define_versions :generate_versions do |c|
  c.teamcity_url = 'phoenix.teamcity.ci.ttldev'
  c.build_configuration_name = 'RabbitToggleAPI_PreRelease_2_Development'
  c.formal_version = RELEASE_VERSION
end



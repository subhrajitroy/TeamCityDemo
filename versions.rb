class DefineVersionsConfig
  attr_accessor :teamcity_url
  attr_accessor :build_configuration_name
  attr_accessor :formal_version
end

class DefineVersionsTask

  def initialize(config)
    raise '[define_version] teamcity_url config missing' if config.teamcity_url.to_s.empty?
    raise '[define_version] build_configuration_name config missing' if config.build_configuration_name.to_s.empty?
    raise '[define_version] formal_version config missing' if config.formal_version.to_s.empty?

    @config = config
  end

  def execute
    ENV['SEMANTIC_VERSION'] = semantic_version
    ENV['DM_VERSION'] = dm_version unless local_build?
    ENV['ASSEMBLY_INFO_VERSION'] = assembly_info_version

    puts 'I am here'
  end

  private

  def release?
    not ENV['RELEASE'].to_s.empty?
  end

  def local_build?
    ENV['BUILD_NUMBER'].to_s.empty?
  end

  def assembly_info_version
    version = @config.formal_version.dup
    if release?
      version << '.0'
    else
      version << '.1'
    end

    version
  end

  def dm_version
    version = ENV['BUILD_NUMBER'].dup

    if version.include? 'alpha'
      version << 'd'
    else
      version << '.'
    end

    version << ( ENV['DM_BUILD_COUNTER'] || '0' )
  end

  def last_build_number
    "0.0.0.#{rand(1000..9999)}"
  end

  def semantic_version
    version = @config.formal_version.dup
    build_counter = 1

    if not release? and not local_build?
      current_build_number = last_build_number
      if current_build_number.include? version
        build_counter = current_build_number.split('.').last.to_i
        build_counter+=1
      end

      version << ".#{build_counter}"
    end

    version << '.local' if local_build?
    puts "Version is " << version
    version
  end

end

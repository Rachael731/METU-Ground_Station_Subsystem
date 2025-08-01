# OpenC3 COSMOS LoRa METUCUBE Plugin Rakefile
require 'rake'
require 'rake/clean'

PLUGIN_NAME = "openc3-cosmos-lora-METUCUBE"
VERSION = "0.1.0"

# Clean and clobber tasks
CLEAN.include("*.gem", "pkg/")
CLOBBER.include("pkg/", "coverage/", "doc/")

desc "Build the plugin gem"
task :build do
  puts "Building #{PLUGIN_NAME}-#{VERSION}.gem..."
  
  # Create gemspec content
  gemspec_content = <<~GEMSPEC
    Gem::Specification.new do |spec|
      spec.name          = "#{PLUGIN_NAME}"
      spec.version       = "#{VERSION}"
      spec.authors       = ["CubeSat Ground Station Team"]
      spec.email         = ["team@metucube.edu.tr"]
      spec.summary       = "LoRa communication plugin for METUCUBE CubeSat ground station"
      spec.description   = "Provides LoRa communication interface for METUCUBE 3U CubeSat ground station operations using OpenC3 COSMOS"
      spec.homepage      = "https://github.com/metucube/openc3-cosmos-lora-METUCUBE"
      spec.license       = "MIT"
      
      spec.files = Dir.glob("**/*").reject { |f| File.directory?(f) }
      spec.executables   = []
      spec.require_paths = ["lib"]
      
      spec.required_ruby_version = ">= 2.7.0"
      
      # OpenC3 dependency
      spec.add_runtime_dependency "openc3", "~> 5.0"
      
      # Serial communication
      spec.add_runtime_dependency "serialport", "~> 1.3"
      
      # JSON handling
      spec.add_runtime_dependency "json", "~> 2.0"
      
      # For LoRa module communication
      spec.add_runtime_dependency "rubyserial", "~> 0.6"
    end
  GEMSPEC
  
  # Write gemspec file
  File.write("#{PLUGIN_NAME}.gemspec", gemspec_content)
  
  # Build the gem
  system("gem build #{PLUGIN_NAME}.gemspec")
  
  # Clean up temporary gemspec
  File.delete("#{PLUGIN_NAME}.gemspec") if File.exist?("#{PLUGIN_NAME}.gemspec")
  
  puts "Successfully built #{PLUGIN_NAME}-#{VERSION}.gem"
end

desc "Install the plugin gem locally"
task :install => :build do
  puts "Installing #{PLUGIN_NAME}-#{VERSION}.gem..."
  system("gem install #{PLUGIN_NAME}-#{VERSION}.gem")
end

desc "Uninstall the plugin gem"
task :uninstall do
  puts "Uninstalling #{PLUGIN_NAME}..."
  system("gem uninstall #{PLUGIN_NAME}")
end

desc "Run syntax check on Ruby files"
task :syntax do
  puts "Checking Ruby syntax..."
  Dir.glob("**/*.rb").each do |file|
    puts "Checking #{file}..."
    system("ruby -c #{file}")
  end
end

desc "Run basic tests"
task :test do
  puts "Running basic plugin tests..."
  
  # Check if required files exist
  required_files = [
    "plugin.txt",
    "config/targets/LORA_SYSTEM/target.txt",
    "config/targets/LORA_SYSTEM/cmd_tlm/lora_system_cmd.txt",
    "config/targets/LORA_SYSTEM/cmd_tlm/lora_system_tlm.txt"
  ]
  
  missing_files = required_files.reject { |file| File.exist?(file) }
  
  if missing_files.empty?
    puts "✓ All required files present"
  else
    puts "✗ Missing required files:"
    missing_files.each { |file| puts "  - #{file}" }
    exit 1
  end
  
  # Run syntax check
  Rake::Task[:syntax].invoke
  
  puts "✓ Basic tests passed"
end

desc "Package plugin for distribution"
task :package => [:clean, :test, :build] do
  puts "Plugin packaged successfully!"
  puts "Generated: #{PLUGIN_NAME}-#{VERSION}.gem"
end

desc "Show plugin information"
task :info do
  puts "Plugin: #{PLUGIN_NAME}"
  puts "Version: #{VERSION}"
  puts "Files:"
  Dir.glob("**/*").reject { |f| File.directory?(f) }.sort.each do |file|
    puts "  #{file}"
  end
end

desc "Validate plugin structure"
task :validate do
  puts "Validating plugin structure..."
  
  # Check directory structure
  required_dirs = [
    "config/targets/LORA_SYSTEM",
    "config/targets/LORA_SYSTEM/cmd_tlm",
    "config/targets/LORA_SYSTEM/procedures"
  ]
  
  required_dirs.each do |dir|
    if Dir.exist?(dir)
      puts "✓ Directory exists: #{dir}"
    else
      puts "✗ Missing directory: #{dir}"
    end
  end
  
  # Check file contents
  if File.exist?("plugin.txt")
    content = File.read("plugin.txt")
    if content.include?("TARGET LORA_SYSTEM")
      puts "✓ plugin.txt contains target definition"
    else
      puts "✗ plugin.txt missing target definition"
    end
  end
  
  puts "Validation complete"
end

# Default task
task :default => :package

# Help task
desc "Show available tasks"
task :help do
  puts "Available tasks:"
  puts "  rake build     - Build the plugin gem"
  puts "  rake install   - Install the plugin gem locally"
  puts "  rake uninstall - Uninstall the plugin gem"
  puts "  rake test      - Run basic tests"
  puts "  rake syntax    - Check Ruby syntax"
  puts "  rake validate  - Validate plugin structure"
  puts "  rake package   - Package plugin for distribution (default)"
  puts "  rake info      - Show plugin information"
  puts "  rake clean     - Clean temporary files"
  puts "  rake help      - Show this help"
end
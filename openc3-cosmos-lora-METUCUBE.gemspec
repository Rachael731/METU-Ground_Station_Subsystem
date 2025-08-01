# encoding: utf-8

require 'date'

Gem::Specification.new do |spec|
  spec.name          = 'openc3-cosmos-lora-metucube'
  spec.version       = '1.0.0'
  spec.authors       = ['METU CubeSat Team']
  spec.email         = ['cubesat@metu.edu.tr']
  spec.summary       = 'COSMOS OpenC3 LoRa Interface Plugin for METUCUBE'
  spec.description   = 'A COSMOS plugin for interfacing with LoRa modules for CubeSat ground station communication'
  spec.homepage      = 'https://github.com/metu-cubesat/openc3-cosmos-lora-metucube'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = spec.homepage
    spec.metadata['changelog_uri'] = "#{spec.homepage}/CHANGELOG.md"
  end

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.glob("{lib,config,microservices}/**/*") + 
               %w[plugin.txt Rakefile README.md requirements.txt .gitignore]
  
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_runtime_dependency 'openc3', '~> 5.0', '>= 5.0.0'

  # Development dependencies
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.0'
  spec.add_runtime_dependency "google-protobuf", "~> 3.21.12"


  # Minimum Ruby version
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  # Additional metadata
  spec.post_install_message = <<~MSG
    
    ====================================================
    COSMOS LoRa METUCUBE Plugin installed successfully!
    ====================================================
    
    Next steps:
    1. Configure your LoRa module connection in plugin.txt
    2. Start the LoRa bridge microservice
    3. Test communication using the provided procedures
    
    For more information, see README.md
    
  MSG
end
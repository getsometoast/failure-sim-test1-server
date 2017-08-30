require 'rake'

task default: %w[run]

task :run do
  `shotgun server.rb -o 0.0.0.0`
end

task :test do
  ruby "test/unittest.rb"
end

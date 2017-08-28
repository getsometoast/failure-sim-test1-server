require 'rake'

task default: %w[run]

task :run do
  `shotgun server.rb`
end

task :test do
  ruby "test/unittest.rb"
end

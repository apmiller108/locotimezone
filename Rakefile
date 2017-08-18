require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :run do
  exec 'pry -r locotimezone -I ./lib -e '\
    '"Locotimezone.configure { |c| c.google_api_key = ENV[\'GOOGLE_API_KEY\'] }"'
end

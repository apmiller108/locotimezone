require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

task :run do
  exec 'pry -r locotimezone -I ./lib -e '\
    '"Locotimezone.configure { |c| c.google_api_key = ENV[\'GOOGLE_API_KEY\'] }"'
end

task :default => :test

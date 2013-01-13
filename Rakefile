require 'rake'
require 'rake/testtask'
require 'rdoc/task'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the devise_imapable plugin.'
Rake::TestTask.new(:test) do |t|
  # t.libs << 'lib'
  # t.libs << 'test'
  # t.pattern = 'test/**/*_test.rb'
  # t.verbose = true
  puts <<-eof

*** NOTICE ***

All tests are done in the sample Rails app. 

Please go to test/rails_app and run the tests there. 

Make sure to bundle install and rake db:migrate

  eof
end

desc 'Generate documentation for the devise_crowd_authenticatable plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'DeviseCrowdAuthenticatable'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "devise_crowd_authenticatable"
    gemspec.summary = "Crowd authentication module for Devise"
    gemspec.description = "Crowd authentication module for Devise"
    gemspec.email = "parmarg@gmail.com"
    gemspec.homepage = "http://github.com/parmarg/devise_crowd_authenticatable"
    gemspec.authors = ["Gurp Parmar"]
    gemspec.add_runtime_dependency "devise", "1.1.2"

  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

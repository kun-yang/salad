# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

require 'cucumber/rake/task' unless FileTest.exists?("cucumber/rake/task") == false
require 'spec/rake/spectask' unless FileTest.exists?("spec/rake/spectask") == false

# todo Do a check to make sure the selenium tasks are accessible
require 'selenium/rake/tasks' 

namespace :rcov do
  if defined? Cucumber
    Cucumber::Rake::Task.new(:cucumber) do |t|
      t.rcov = true
      t.rcov_opts = IO.readlines("#{RAILS_ROOT}/spec/rcov.opts").map {|l| l.chomp.split " "}.flatten
    end

    Cucumber::Rake::Task.new(:selenium, 'Run Selenium based features') do |t|
      t.rcov = true
      t.cucumber_opts = %w{-p selenium}
      t.rcov_opts = IO.readlines("#{RAILS_ROOT}/spec/rcov.opts").map {|l| l.chomp.split " "}.flatten
    end

    Spec::Rake::SpecTask.new(:rspec) do |t|
      t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/spec.opts\""]
      t.spec_files = FileList['spec/**/*_spec.rb']
      t.rcov = true
      t.rcov_opts = lambda do
        IO.readlines("#{RAILS_ROOT}/spec/rcov.opts").map {|l| l.chomp.split " "}.flatten
      end
    end

    desc "Run both specs and features to generate aggregated coverage"
    task :all do |t|
      rm "coverage.data" if File.exist?("coverage.data")
      Rake::Task["rcov:rspec"].invoke
      Rake::Task["rcov:cucumber"].invoke
      Rake::Task["rcov:selenium"].invoke
    end
  end
end

if defined? Selenium
  Selenium::Rake::RemoteControlStartTask.new do |rc|
    rc.port = 4444
    rc.timeout_in_seconds = 3 * 60
    rc.background = true
    rc.wait_until_up_and_running = true
    rc.jar_file = "~/selenium-server/selenium-server.jar"
    rc.additional_args << "-singleWindow"
  end

  Selenium::Rake::RemoteControlStopTask.new do |rc|
    rc.host = "localhost"
    rc.port = 4444
    rc.timeout_in_seconds = 3 * 60
  end
end
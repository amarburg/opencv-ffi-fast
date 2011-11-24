require "bundler/gem_tasks"
require 'rake/testtask'
require 'rake/clean'

require "./ext/mkrf-rakehelper-monkey"

setup_extension "fast", "libcvffi_fast"


Rake::TestTask.new(:test) do |t|
  #  t.libs << 'lib/opencv-ffi' << '.'
  t.libs << '.'
  t.verbose = true
  t.test_files = FileList['test/test_*.rb']
end

CLEAN.include "lib/*.so"
  
task :default => 'test'

task :test => Mkrf::all_libs


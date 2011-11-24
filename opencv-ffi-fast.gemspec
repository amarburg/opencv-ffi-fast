# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "opencv-ffi-fast/version"

Gem::Specification.new do |s|
  s.name        = "opencv-ffi-fast"
  s.version     = CVFFI::FAST::VERSION
  s.authors     = ["Aaron Marburg"]
  s.email       = ["aaron.marburg@pg.canterbury.ac.nz"]
  s.homepage    = ""
  s.summary     = %q{Edward Rosten's FAST keypoint detector algorithm, as a plug-in for OpenCV-FFI.}
  s.description = %q{Edward Rosten's FAST keypoint detector algorithm, as a plug-in for OpenCV-FFI.}

  s.rubyforge_project = "opencv-ffi-fast"

  s.files         = `git ls-files`.split("\n")
  s.extensions    = "ext/mkrf_conf.rb"
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "nice-ffi"
  s.add_dependency "mkrf"
  s.add_dependency "opencv-ffi"
end

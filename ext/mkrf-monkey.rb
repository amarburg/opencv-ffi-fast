
puts Gem.all_load_paths

require 'mkrf'

# I admit it, I'm monkey-patching mkrf to get the behavior I want.
module Mkrf

  class Generator

    def rakefile_contents # :nodoc:
      objext = CONFIG['OBJEXT']
      cc = CONFIG['CC'] || 'gcc'
      cpp = CONFIG['CXX'] || 'g++'
      extension_sym = File.basename( @extension_name, ".#{CONFIG['DLEXT']}" ).to_sym


      <<-END_RAKEFILE
# Generated by mkrf, monkey patched for opencv-ffi
require 'rake/clean'


SRC = FileList[#{sources.join(',')}]
OBJ = SRC.ext('#{objext}')
CC = '#{cc}'
CPP = '#{cpp}'

CLEAN.include(OBJ)
CLOBBER.include('#{@extension_name}', 'mkrf.log', 'Rakefile')

ADDITIONAL_OBJECTS = '#{objects}'

LDSHARED = "#{@available.ldshared_string} #{ldshared}"

LIBPATH =  "#{library_path(CONFIG['libdir'])} #{@available.library_paths_compile_string}"

INCLUDES = "#{@available.includes_compile_string}"

LIBS = "#{@available.library_compile_string}"

CFLAGS = "#{cflags} #{defines_compile_string}"

RUBYARCHDIR = "\#{ENV["RUBYARCHDIR"]}"
LIBRUBYARG_SHARED = "#{CONFIG['LIBRUBYARG_SHARED']}"

task :default => :build_library

# Add one layer of indirection so I can generically call "rake build_library"
# and have it work ... or not work if the wrong rakefile is being run
task :build_library => '#{@extension_name}'

rule '.#{objext}' => '.c' do |t|
  sh "\#{CC} \#{CFLAGS} \#{INCLUDES} -o \#{t.name} -c \#{t.source}"
end

rule '.#{objext}' => '.cpp' do |t|
  sh "\#{CPP} \#{CFLAGS} \#{INCLUDES} -o \#{t.name} -c \#{t.source}"
end

DEPS = OBJ.clone.add('Rakefile')
desc "Build this extension"
file '#{@extension_name}' => DEPS do
  sh "\#{LDSHARED} \#{LIBPATH} #{@available.ld_outfile(@extension_name)} \#{OBJ} \#{ADDITIONAL_OBJECTS} \#{LIBS} \#{LIBRUBYARG_SHARED}"
end

desc "Rebuild rakefile"
file 'Rakefile' => 'mkrf_conf.rb' do |t|
  ruby 'mkrf_conf.rb'
  puts "Rebuilt Rakefile.  Run \'rake #{extension_sym.to_s}\' again"
end

desc "Install this extension"
task :install => '#{@extension_name}' do
  makedirs "\#{RUBYARCHDIR}"
  install "#{@extension_name}", "\#{RUBYARCHDIR}"
end

#{additional_code}
      END_RAKEFILE
    end
 

  end

end



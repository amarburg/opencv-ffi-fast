# Something in the bundler/gem install process is sanitizing
# the Gem path and I can't find mkrf...
ENV['GEM_PATH'] = ENV['_ORIGINAL_GEM_PATH']
require '../mkrf-monkey'

Mkrf::Generator.new('libcvffi_fast', [ "*.c"]) { |g|
}



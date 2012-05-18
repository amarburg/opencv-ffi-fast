
require 'nice-ffi'
require 'opencv-ffi'

module CVFFI
  module FAST

    class FASTResults
      include Enumerable

      attr_accessor :points
      attr_accessor :nPoints

      def initialize( pts, nPts )
        @points = pts
        @nPoints = nPts

        # Define a destructor do dispose of the results
        destructor = Proc.new { pts.free }
        ObjectSpace.define_finalizer( self, destructor )
      end

      def each
        if @nPoints > 0
          0.upto(@nPoints-1) { |i|
            yield Xy.new( @points[i] )
          }
        end
      end

      alias :size :nPoints

    end

    class Params
      attr_accessor :points, :threshold

      VALID_SIZES = [ 9, 10, 11, 12 ]

      def size_valid?( sz )
        VALID_SIZES.include? sz
      end

      def initialize( opts = {} )
        p opts
        @points = opts[:points] ||  9
        @threshold = opts[:threshold] || 20

        raise "Hm, invalid size #{@points} specified for FAST keypoint detector" unless size_valid? @points
      end

      def to_hash
        { :points => @points, :threshold => @threshold }
      end
    end


    def self.detect( img, params )
      FASTDetect( params.points, img, params.threshold )
    end

    def self.FASTDetect( size, img, threshold )
      nResults = FFI::MemoryPointer.new :int

      if img.is_a?( IplImage )
        # Ensure the image is b&w
        img = img.ensure_greyscale

        results = FFI::Pointer.new :pointer, method("fast#{size}_detect").call( img.imageData, img.width, img.height, img.widthStep, threshold, nResults )
      else
        raise ArgumentError, "Don't know how to deal with image class #{img.class}"
      end

      # Dereference the two pointers
      nPoints = nResults.read_int
      points = FFI::Pointer.new Xy, results

      FASTResults.new( points, nPoints )
    end

    def self.FAST9Detect( img, threshold );  FASTDetect( 9, img, threshold ); end
    def self.FAST10Detect( img, threshold ); FASTDetect( 10, img, threshold ); end
    def self.FAST11Detect( img, threshold ); FASTDetect( 11, img, threshold ); end
    def self.FAST12Detect( img, threshold ); FASTDetect( 12, img, threshold ); end

#
## Here's the actual FFI interface
#
    extend NiceFFI::Library

    libs_dir = File.dirname(__FILE__) + "/../../ext/fast/"
    pathset = NiceFFI::PathSet::DEFAULT.prepend( libs_dir )
    load_library("cvffi_fast", pathset)

    class Xy < NiceFFI::Struct
      layout :x, :int,
             :y, :int
    end

    # Leave result as pointer, not Xy.typed_pointer as it makes it easier to deference
    # it to an array of Xy

    def self.fast_detect_function( sz )
      attach_function "fast#{sz}_detect".to_sym, [ :pointer, :int, :int, :int, :int, :pointer ], :pointer
    end

    fast_detect_function 9
    fast_detect_function 10
    fast_detect_function 11
    fast_detect_function 12

  end
end

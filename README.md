OpenCV-FFI "FAST" Keypoint Detector
===================================

Introduction
------------

This Gem contains builds a native extension/plug-in to
[OpenCV-FFI](https://github.com/amarburg/opencv-ffi) which contains
Edward Rosten's [FAST](http://www.edwardrosten.com/work/fast.html)
feature detector.

Yes, I know OpenCV's C++ API provides a FAST function.  I created this GEM
partly as an experiment in adding 3rd-party code to the OpenCV-FFI space,
and also to avoid having to write another set of C++-to-C wrappers.
I have not run this code in parallel with the OpenCV code base, I do
not know how they differ.

It includes the binary and a set of Ruby-space wrappers in the
`CVFFI::FAST` module.

Most/all of this code was once in the main OpenCV-FFI project, but was
moved out to give a semblance of modularity.

Acknowledgements and License
----------------------------

If you use this Gem for academic work, please be sure to cite Edward's
papers as per the request on his page:

+ [Rosten, E. and Drummond T. "Machine learning for high-speed corner detection."  European Conference on Computer Vision, 2006.](http://www.edwardrosten.com/work/papers.html#rosten_2006_machine)

+ [Rosten, E. and Drummond, T.  "Fusing points and lines for high performance tracking."   IEEE International Conference on Computer Vision, 2005.](http://www.edwardrosten.com/work/papers.html#rosten_2005_tracking)

Both may be found [here](http://www.edwardrosten.com/work/papers.html)

The Gem itself is licensed under the MIT license.

As noted, Edward has released his source code under the BSD license:

Copyright (c) 2006, 2008, 2009, 2010 Edward Rosten
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:


*Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.

*Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

*Neither the name of the University of Cambridge nor the names of 
its contributors may be used to endorse or promote products derived 
from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Copyright
---------

Copyright (c) 2011 by Aaron Marburg


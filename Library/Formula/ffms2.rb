class Ffms2 < Formula
  desc "Libav/ffmpeg based source library and Avisynth plugin"
  homepage "https://github.com/FFMS/ffms2"
  url "https://github.com/FFMS/ffms2/archive/2.21.tar.gz"
  mirror "https://mirrors.kernel.org/debian/pool/main/f/ffms2/ffms2_2.21.orig.tar.gz"
  sha256 "c2c23ce2254e293376f786aafc20a345f4dc970f5b2efef3fa38e40d7d510202"

  bottle do
    cellar :any
    sha256 "04726b5c91736f834e59fab880bc5dbe674e1fd2a12eaeb58f5ad7f3abfe3b85" => :yosemite
    sha256 "5e0606d2c83e377963dde83af58114e6c08d50e6240824671263939b41d1e664" => :mavericks
    sha256 "a487b80dd08906279aa6b80ffa33162f7ec1520ec4a862f7e9eae25b56d5488e" => :mountain_lion
  end

  head do
    url "https://github.com/FFMS/ffms2.git"

    depends_on "automake" => :build
    depends_on "autoconf" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "ffmpeg"

  resource "videosample" do
    url "http://samples.mplayerhq.hu/V-codecs/lm20.avi"
    sha256 "a0ab512c66d276fd3932aacdd6073f9734c7e246c8747c48bf5d9dd34ac8b392"
  end

  def install
    # For Mountain Lion
    ENV.libcxx

    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --enable-avresample
      --prefix=#{prefix}
    ]

    if build.head?
      system "./autogen.sh", *args
    else
      system "./configure", *args
    end

    system "make", "install"
  end

  test do
    # download small sample and check that the index was created
    resource("videosample").stage do
      system "ffmsindex", "lm20.avi"
      assert File.exist? "lm20.avi.ffindex"
    end
  end
end

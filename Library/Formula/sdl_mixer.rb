class SdlMixer < Formula
  desc "Sample multi-channel audio mixer library"
  homepage "http://www.libsdl.org/projects/SDL_mixer/"
  url "http://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-1.2.12.tar.gz"
  sha256 "1644308279a975799049e4826af2cfc787cad2abb11aa14562e402521f86992a"

  bottle do
    cellar :any
    sha1 "1ad2648cd71bd7f13eae35cdcb6c89573908bd24" => :mavericks
    sha1 "980edb62430840facb54ab8cd065eea576fba9c5" => :mountain_lion
    sha1 "5ba6a1d7bc5dc2a8b032ce45e779b7cbd8d91d42" => :lion
  end

  option :universal

  depends_on "pkg-config" => :build
  depends_on "sdl"
  depends_on "flac" => :optional
  depends_on "libmikmod" => :optional
  depends_on "libvorbis" => :optional

  def install
    inreplace "SDL_mixer.pc.in", "@prefix@", HOMEBREW_PREFIX

    ENV.universal_binary if build.universal?

    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking"
    system "make", "install"
  end
end

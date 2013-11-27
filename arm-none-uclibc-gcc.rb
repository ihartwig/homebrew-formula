require 'formula'

class ArmLinuxGcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftpmirror.gnu.org/gcc/gcc-4.7.2/gcc-4.7.2.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.7.2/gcc-4.7.2.tar.bz2'
  sha1 'a464ba0f26eef24c29bcd1e7489421117fb9ee35'

  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on 'arm-linux-binutils'

  def install
    binutils = Formula.factory 'arm-linux-binutils'

    ENV['CC'] = '/usr/local/bin/gcc-4.2'
    ENV['CXX'] = '/usr/local/bin/g++-4.2'
    ENV['CPP'] = '/usr/local/bin/cpp-4.2'
    ENV['LD'] = '/usr/local/bin/gcc-4.2'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"

    mkdir 'build' do
      system '../configure', "--prefix=#{prefix}",
                             "--build=i386-pc-linux-gnu",
                             "--host=i386-pc-linux-gnu",
                             "--target=arm-linux-uclibc",
                             "--enable-languages=c",
                             "--enable-shared",
                             "--disable-__cxa_atexit",
                             "--enable-target-optspace",
                             "--with-gnu-ld",
                             "--disable-nls",
                             "--enable-threads",
                             "--disable-multilib",
                             "--with-float=soft",
                             "--with-cpu=xscale",
                             "--with-arch=armv5te",
                             "--with-tune=xscale"
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"arm-linux", prefix/"arm-linux"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end
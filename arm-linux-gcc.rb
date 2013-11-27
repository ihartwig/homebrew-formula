require 'formula'

class ArmLinuxGcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftpmirror.gnu.org/gcc/gcc-4.1.1/gcc-4.1.1.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.1.1/gcc-4.1.1.tar.bz2'
  sha1 '0f5c10d155d7ef67c5eb1261f84e70e2b92293fa'

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
                             "--build=x86_64-pc-linux-gnu",
                             "--host=x86_64-pc-linux-gnu",
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
      system 'make all-gcc -v'
      system 'make install-gcc -v'
      FileUtils.ln_sf binutils.prefix/"arm-linux", prefix/"arm-linux"
      system 'make all-target-libgcc -v'
      system 'make install-target-libgcc -v'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end
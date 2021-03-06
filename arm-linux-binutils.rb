require 'formula'

class ArmLinuxBinutils < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftp.gnu.org/gnu/binutils/binutils-2.17a.tar.bz2'
  sha1 '0f5c10d155d7ef67c5eb1261f84e70e2b92293fa'

  depends_on 'apple-gcc42' => :build

  def install
    ENV['CC'] = '/usr/local/bin/gcc-4.2'
    ENV['CXX'] = '/usr/local/bin/g++-4.2'
    ENV['CPP'] = '/usr/local/bin/cpp-4.2'
    ENV['LD'] = '/usr/local/bin/gcc-4.2'

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=arm-linux-uclibc',
                             '--enable-gold=yes',
                             "--prefix=#{prefix}"
      system 'make all -v'
      system 'make install'
      FileUtils.mv lib, libexec
    end
  end

end
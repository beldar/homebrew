require 'formula'

class AircrackNg < Formula
  homepage 'http://aircrack-ng.org/'
  url 'http://download.aircrack-ng.org/aircrack-ng-1.2-beta1.tar.gz'
  sha1 '928b327ff47a31891a0edfdc1dc6a80914336458'

  def install
    # Force i386, otherwise you get errors:
    #  sha1-sse2.S:190:32-bit absolute addressing is not supported for x86-64
    #  sha1-sse2.S:190:cannot do signed 4 byte relocation
    %w{ CFLAGS CXXFLAGS LDFLAGS OBJCFLAGS OBJCXXFLAGS }.each do |compiler_flag|
      ENV.remove compiler_flag, "-arch x86_64"
      ENV.append compiler_flag, "-arch i386"
    end

    system "make", "CC=#{ENV.cc}"
    system "make", "prefix=#{prefix}", "mandir=#{man1}", "install"
  end

  def caveats;  <<-EOS.undent
    Run `airodump-ng-oui-update` install or update the Airodump-ng OUI file.
    EOS
  end
end

__END__
-USERID=""
-
-
-# Make sure the user is root
-if [ x"`which id 2> /dev/null`" != "x" ]
-then
-	USERID="`id -u 2> /dev/null`"
-fi
-
-if [ x$USERID = "x" -a x$UID != "x" ]
-then
-	USERID=$UID
-fi
-
-if [ x$USERID != "x" -a x$USERID != "x0" ]
-then
-	echo Run it as root ; exit ;
-fi
-
 
 if [ ! -d "${OUI_PATH}" ]; then
 	mkdir -p ${OUI_PATH}


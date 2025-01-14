# $Id: Makefile.wmk,v 1.6 2013/06/26 19:34:18 msheby Exp $
# Copyright (c) 2007-2012 John Hurst. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. The name of the author may not be used to endorse or promote products
#    derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


SRCDIR = ..\src
OBJDIR = .

!ifndef WITH_OPENSSL
!error "OpenSSL is needed! Specify it with WITH_OPENSSL=<OpenSSL directory>"
!endif

!ifdef ENABLE_RANDOM_UUID
CXXFLAGS1 = /nologo /W3 /GR /EHsc /DWIN32 /DKM_WIN32 /D_CONSOLE /I. /I$(SRCDIR) /DASDCP_PLATFORM=\"win32\" \
	/D_CRT_SECURE_NO_WARNINGS /D_CRT_NONSTDC_NO_WARNINGS /DPACKAGE_VERSION=\"2.4.10\" \
	/I"$(WITH_OPENSSL)"\inc32 /DCONFIG_RANDOM_UUID=1
!else
CXXFLAGS1 = /nologo /W3 /GR /EHsc /DWIN32 /DKM_WIN32 /D_CONSOLE /I. /I$(SRCDIR) /DASDCP_PLATFORM=\"win32\" \
	/D_CRT_SECURE_NO_WARNINGS /D_CRT_NONSTDC_NO_WARNINGS /DPACKAGE_VERSION=\"2.4.10\" \
	/I"$(WITH_OPENSSL)"\inc32
!endif
LIB_EXE = lib.exe
LIBFLAGS1 = /NOLOGO /LIBPATH:"$(WITH_OPENSSL)"\out32dll

LINK = link.exe
LINKFLAGS1 = /NOLOGO /SUBSYSTEM:console /MACHINE:I386 /LIBPATH:. /DEBUG


!ifdef DEBUG
CXXFLAGS2 = $(CXXFLAGS1) /MTd /DDEBUG /D_DEBUG /Od /RTC1 /ZI
LINKFLAGS = $(LINKFLAGS1) /DEBUG
!else
CXXFLAGS2 = $(CXXFLAGS1) /MT /DNDEBUG /D_NDEBUG /O2
LINKFLAGS = $(LINKFLAGS1)
!endif

!IFDEF WITH_XERCES
!ifdef WITH_XML_PARSER
!ERROR "Cannot include both Expat and Xerces-C++!"
!endif

CXXFLAGS = $(CXXFLAGS2) /DHAVE_XERCES_C=1 /I"$(WITH_XERCES)"\include
LIBFLAGS = $(LIBFLAGS1) /LIBPATH:"$(WITH_XERCES)"\lib
!ELSEIFDEF WITH_XML_PARSER
CXXFLAGS = $(CXXFLAGS2) /DASDCP_USE_EXPAT /I"$(WITH_XML_PARSER)"\Source\lib
!IFDEF DEBUG
LIBFLAGS = $(LIBFLAGS1) /LIBPATH:"$(WITH_XML_PARSER)"\Source\win32\bin\debug
!ELSE
LIBFLAGS = $(LIBFLAGS1) /LIBPATH:"$(WITH_XML_PARSER)"\Source\win32\bin\release
!ENDIF
!ELSE
CXXFLAGS = $(CXXFLAGS2)
LIBFLAGS = $(LIBFLAGS1)
!ENDIF

CPPFLAGS = $(CXXFLAGS)

KUMU_OBJS = KM_fileio.obj KM_log.obj KM_prng.obj KM_util.obj KM_xml.obj KM_tai.obj
ASDCP_OBJS = MPEG2_Parser.obj MPEG.obj JP2K_Codestream_Parser.obj \
	JP2K_Sequence_Parser.obj JP2K.obj PCM_Parser.obj Wav.obj \
	TimedText_Parser.obj KLV.obj Dict.obj MXFTypes.obj MXF.obj \
	Index.obj Metadata.obj AS_DCP.obj AS_DCP_MXF.obj AS_DCP_AES.obj \
	h__Reader.obj h__Writer.obj AS_DCP_MPEG2.obj AS_DCP_JP2K.obj \
	AS_DCP_PCM.obj AS_DCP_TimedText.obj PCMParserList.obj \
	MDD.obj AS_DCP_ATMOS.obj AS_DCP_DCData.obj \
	DCData_ByteStream_Parser.obj DCData_Sequence_Parser.obj \
	AtmosSyncChannel_Generator.obj AtmosSyncChannel_Mixer.obj \
	PCMDataProviders.obj SyncEncoder.obj CRC16.obj \
	UUIDInformation.obj
AS02_OBJS = h__02_Reader.obj h__02_Writer.obj AS_02_JP2K.obj \
	AS_02_PCM.obj

{$(SRCDIR)\}.cpp{}.obj:
	$(CXX) $(CXXFLAGS) -Fd$(OBJDIR)\ /c $<

{$(SRCDIR)\}.c{}.obj:
	$(CXX) $(CXXFLAGS) -Fd$(OBJDIR)\ /c $<

all: kmfilegen.exe kmrandgen.exe kmuuidgen.exe asdcp-test.exe \
     asdcp-wrap.exe asdcp-unwrap.exe asdcp-info.exe \
     blackwave.exe klvwalk.exe j2c-test.exe wavesplit.exe 
!IFDEF USE_AS_02
       as-02-wrap.exe as-02-unwrap.exe \
!ENDIF

clean:
	erase *.exe *.lib *.obj *.ilk *.pdb *.idb

libkumu.lib : $(KUMU_OBJS)
!IFDEF WITH_XERCES
!IFDEF DEBUG
	$(LIB_EXE) $(LIBFLAGS) /OUT:libkumu.lib $** libeay32.lib xerces-c_2D.lib
!ELSE
	$(LIB_EXE) $(LIBFLAGS) /OUT:libkumu.lib $** libeay32.lib xerces-c_2.lib
!ENDIF
!ELSEIFDEF WITH_XML_PARSER
	$(LIB_EXE) $(LIBFLAGS) /OUT:libkumu.lib $** libeay32.lib libexpatMT.lib
!ELSE
	$(LIB_EXE) $(LIBFLAGS) /OUT:libkumu.lib $** libeay32.lib
!ENDIF 

libasdcp.lib: libkumu.lib $(ASDCP_OBJS)
	$(LIB_EXE) $(LIBFLAGS) /OUT:libasdcp.lib $**

!IFDEF USE_AS_02
libas02.lib: libasdcp.lib libkumu.lib $(AS02_OBJS)
	$(LIB_EXE) $(LIBFLAGS) /OUT:libas02.lib $**
!ENDIF

blackwave.exe: libasdcp.lib blackwave.obj
	$(LINK) $(LINKFLAGS) /OUT:blackwave.exe $** Advapi32.lib

wavesplit.exe: libasdcp.lib wavesplit.obj
	$(LINK) $(LINKFLAGS) /OUT:wavesplit.exe $** Advapi32.lib

kmuuidgen.exe: libkumu.lib kmuuidgen.obj
	$(LINK) $(LINKFLAGS) /OUT:kmuuidgen.exe $** Advapi32.lib

kmrandgen.exe: libkumu.lib kmrandgen.obj
	$(LINK) $(LINKFLAGS) /OUT:kmrandgen.exe $** Advapi32.lib

kmfilegen.exe: libkumu.lib kmfilegen.obj
	$(LINK) $(LINKFLAGS) /OUT:kmfilegen.exe $** Advapi32.lib

klvwalk.exe: libasdcp.lib klvwalk.obj
	$(LINK) $(LINKFLAGS) /OUT:klvwalk.exe $** Advapi32.lib

asdcp-test.exe: libasdcp.lib asdcp-test.obj
	$(LINK) $(LINKFLAGS) /OUT:asdcp-test.exe $** Advapi32.lib

asdcp-wrap.exe: libasdcp.lib asdcp-wrap.obj
	$(LINK) $(LINKFLAGS) /OUT:asdcp-wrap.exe $** Advapi32.lib

asdcp-unwrap.exe: libasdcp.lib asdcp-unwrap.obj
	$(LINK) $(LINKFLAGS) /OUT:asdcp-unwrap.exe $** Advapi32.lib

asdcp-info.exe: libasdcp.lib asdcp-info.obj
	$(LINK) $(LINKFLAGS) /OUT:asdcp-info.exe $** Advapi32.lib

asdcp-util.exe: libasdcp.lib asdcp-util.obj
	$(LINK) $(LINKFLAGS) /OUT:asdcp-util.exe $** Advapi32.lib

j2c-test.exe: libasdcp.lib j2c-test.obj
	$(LINK) $(LINKFLAGS) /OUT:j2c-test.exe $** Advapi32.lib

!IFDEF USE_AS_02
as-02-wrap.exe: libas02.lib as-02-wrap.obj
	$(LINK) $(LINKFLAGS) /OUT:as-02-wrap.exe $** Advapi32.lib

as-02-unwrap.exe: libas02.lib as-02-unwrap.obj
	$(LINK) $(LINKFLAGS) /OUT:as-02-unwrap.exe $** Advapi32.lib
!ENDIF


# END Makefile

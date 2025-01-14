asdcplib
========

Fork from http://www.cinecert.com/asdcplib/


README,v 1.84 2013/07/02 21:29:09 mikey
---------------------------------------

The asdcplib library is a set of objects that offer
simplified access to files conforming to the sound and
picture track file formats developed by the SMPTE Working
Group DC28.20 (now TC 21DC).

Recently, support has also been added for SMPTE draft ST
2067-5 "IMF Essence Component", AKA "AS-02".  This code was
donated by Fraunhofer IIS.  It carries additional copyright
information which should be listed whenever you link the
AS-02 elements of the library.  Please look at the top of
the AS-02 files to see this copyright information.

AS-02 support is carried in separate object modules, so
unless you #include <AS_02.h> and link libas-02.so you are
still using plain old asdcp.

This work was originally funded by Digital Cinema Initiatives,
LLC (DCI). Subsequent efforts have been funded by Deluxe
Laboratories, Doremi Labs, CineCert LLC, Avica Technology
and others.

> The asdcplib project was originally housed on SourceForge.
The project has moved to http://www.cinecert.com/asdcplib/

The project formerly depended upon the mxflib project. Because
of its focus on covering the whole of the MXF specifications,
mxflib is considerably larger and more complex that what I
require for this application. For this reason I have created
a dedicated MXF implementation that is now part of this
library. Special thanks to Matt Beard and Oliver Morgan for
their great work and support.

Thanks also to the members of the SMPTE DC28.20 packaging
ad-hoc group and the members of the MXF Interop Initiative
for their encouragement and support. Special thanks to
Jim Whittlesey and Howard Lukk at DCI for proposing and
supporting this project.


Design Notes
------------

This library is intended (but of course not limited) for
use by developers of commercial D-Cinema products (and now
IMF!).  It is designed to be easily integrated into a wide
variety of development environments.  Commercial users are
strongly urged to use static linking (at least where you use
this library) to prevent malicious in-field replacement of
critical system modules. This recommendation should be
considered wherever Open Source or Free software is being
used in conjunction with critical security parameters, such
as cryptographic keys.

The author strives mightily to provide an API that is completely
independent of operating system and other library dependencies,
and which allows selective replacement of some modules for
local needs.  Specifically, the essence parsers and OpenSSL
crypto functions can be replaced by linking to alternative
implementations of the ASDCP:: objects which provide those
services.

AS_DCP.h contains the entire AS-DCP API.  You do not need to
read any of the other files, except maybe asdcp-test.cpp which
contains detailed usage examples of each of the API's services.
The KM_* files may be of interest for general development
support, but may be ignored if all you want is simple AS-DCP
support.

Likewise, draft 2067-5 "IMF Essence Component" (AS-02) support
is entirely contained in AS-02.h


Build Instructions
------------------

On more-or-less POSIX systems (OS X, Linux, and BSD), GNU make and 
autotools are required to build asdcplib. The same configure script 
will also build this package on Windows machines with Cygwin and
MinGW installed. For those Windows users who would prefer to build
this natively, an "nmake" build file and instructions can be found
in the win32 subdirectory.  

OpenSSL is also required, any recent version should be fine. See
http://www.openssl.org/ for more information and download instructions.

Optional support for writing Timed Text Track Files is supported by
either Xerces-C or Expat. See http://xerces.apache.org/xerces-c/ or
http://expat.sourceforge.net/ for source and build instructions.

To configure and build, type './configure' followed by 'make'. There
are several test targets on the POSIX side, but you need to assemble
a set of test files to use them.  

I have tested this build on win32, Linux, OpenBSD, and Darwin
platforms. Others may work as well.




Utilities
---------

> - **asdcp-test** -  Writes, reads and verifies AS-DCP (MXF) track files.

> - **asdcp-wrap** - Writes AS-DCP (MXF) track files.

> - **asdcp-unwrap** - Extracts essence from AS-DCP (MXF) track files.

> - **asdcp-info** - Displays information about AS-DCP (MXF) track files.

> - **asdcp-util** - Calculates digests and generates random numbers and UUIDs.

> - **as-02-wrap** - Writes AS-02 Essence Component files.

> - **as-02-unwrap** - Extracts essence from AS-02 Essence Component files.

> - **kmfilegen** - Writes and verifies large files using a platform-
independent format. Use it to test issues related to large files.

> - **kmuuidgen, kmrandgen** - generate UUID values and random numbers.

> - **wavesplit** - Splits a WAVE file into two or more output files. Used
  to untangle incorrectly-paired DCDM sound files.

> - **blackwave** - Write a WAVE file full of zeros,  Used to make filler
  tracks (though you would be better off modifying asdcp-test if
  this is a common use case).

> - **j2c-test** - Displays information about JP2K codestreams.


Documentation
-------------

The API documentation is mostly in AS_DCP.h. and AS_02.h  Read those
files for a detailed description of the library's capabilities. Read
asdcp-*.cpp and as-02-*.cpp files for library usage examples. The
command-line utilities all respond to -h.


Change History
--------------

> **2013-07-02 - IMF/AS-02 support, bug fixes 2.0.0**  
  * Massive refactoring of internals to allow easier implementation
    of AS-02.  Some API changes were made as well (note that
    OPAtomHeader is now OP1aHeader and RIP is no longer part of the
    OP1aHeader.)  If you are using this project as a library (and
    especially if you are keeping patches against it) PLEASE TAKE
    TIME TO EVALUATE THIS RELEASE THOUROUGHLY BEFORE ADDING IT TO
    YOUR RELEASE PATH.
  * Final integration of Fraunhoffer IIS code contribution.  AS-02
    files are now fully supported with some TODOs and one major
    exception: LEAD indexes are not supported by the MXF writers
    and interlace images are not yet supported.
  * Added support for MCA labels (ST 428-12) to asdcp-wrap.  Note
    that this project is still in the early stages of interop testing
    so errors are likely present and don't expect any server to
    understand this feature.

> **2013-07-01 - Bug fixes, enhancements 1.12.50**  
  * Fixed missing return statement in ArchivableString::ArchiveLength
    (thanks to both Kristof Provost and Franck Chopin) 
  * Fixed broken sample alignment in RF64Writer (thanks to Dolby)
  * Fixed win32 build (thanks to Dolby)


> **2013-04-12 - Dolby Atmos support and more audio labels 1.11.49**  
  * Significant code contribution from Dolby Laboratories to add
    support for generic data track files as proposed in ST 21DC
    and also Dolby Atmos track file support as a specialization.
  * Added Dolby-contributed code to support generating the external
    sync signal for d-cinema as proposed in ST 21DC.
  * Added Dolby-contributed code to support RF64 WAVE files.
  * Fixed UL error in ST 429-5 DM encoding (contributed by Dolby).
  * Added ULs for ST 428-12 and Amd. 429-2 2013.  Please check!


> **2013-02-20 - bug fixes, enhancements 1.10.48**  
 * Refactored internals of the AS-DCP file readers.  While no
   changes in behavior are intended, users are cautioned to test
   thouroughly before use in production.
 * Fixed a bug in ReadAncillaryResource that was causing bogus HMAC
   failures when reading resources from a file.
 * Fixed premature-release bug in the Expat version of the XML parser.
   Thanks to Carsten Feldheim (IIS) for the tip.
 * Fixed -W option in asdcp-unwrap.  Thanks to RGB.
 * Added P-HFR support to asdcp-wrap (see URL for details:
   http://isdcf.com/papers/ISDCF-HighFrameRate-DCP.pdf).
 * Added support for SMPTE ST 428-21 "Archival Frame Rates".
 * Added -P option to asdcp-wrap (inserts arbitrary UL into the
   PictureEssenceCoding property when wrapping JP2K files.)
 * Added support for 96 kHz files to blackwave.
 * Added new path and string manglers to Kumu.
 * Updated MCA ULs (I warned you...).  Again please take some
   time to proof this work against ST 477-4 including the latest
   drafts of the registries.
       Changed the version byte (8 0f 16) to 0x0e:
           MCALabelSubDescriptor
           AudioChannelLabelSubDescriptor
           SoundfieldGroupLabelSubDescriptor
           GroupOfSoundfieldGroupsLabelSubDescriptor
     GroupOfSoundfieldGroupsLinkID
       Changed bytes 8 and and 13 of SoundfieldGroupLinkID
       Added items to the UL dictionary:
     MCAPartitionKind
	   MCAPartitionNumber
	   MCATitle
	   MCATitleVersion
	   MCATitleSubVersion
	   MCAEpisode
	   MCAAudioContentKind
	   MCAAudioElementKind


> **2012-08-07 - bug fix, 1.10.46**
 * Added missing zero-initializers to time values when parsing a
   timestamp string (in the case where the optional [Thh:mm.[:ss]]
   syntax is not present in an encoded string).

> **2012-03-06 - bug fixes, enhancements 1.9.45**
 * Removed ASDCP::Timestamp, all items that were of that class are now 
   of class Kumu::Timestamp
 * Refactored Kumu::Timestamp to use KM_tai for internal representation 
   (replaced public Y M D, h, m, s variables)
 * Refactored Kumu::Timestamp to use KM_tai for WIN32 builds
 * Added UTC offset awareness to Kumu::Timestamp
 * Replaced "long GetSecondsSinceEpoch(void) const" with 
   "ui64_t GetCTime() const"
 * Corrected UL version segment in "7.1 DS" and "WTF" audio format
   labels (corresponds with publication of ST 429-2:2011).
 * Exposed MXF object interface (MXF.h, Metadata.h) via ASDCP MXFReader
   and MXFWriter classes.
 * Added UL values from ST 377-4:2012. >>>>NOTE: These are preliminary
   values, subject to change upon final publication of not only ST 377-4
   but also the relevant registries.  This is a good time to compare them
   to the standard and complain if you think they are wrong!
 * Added MCALabelSubDescriptor, AudioChannelLabelSubDescriptor,
   SoundfieldGroupLabelSubDescriptor, and
   GroupOfSoundfieldGroupsLabelSubDescriptor (from ST 377-4:2012) to
   Metadata.h
 * Changed some internals to make MXFWriter::OPAtomHeader() work correctly.
 * Split asdcp-test into several different programs to help relieve
   the impenetrable-list-of-arguments problem. asdcp-wrap, asdcp-unwrap
   and asdcp-info take the place of asdcp-test's -c, -x and -i options,
   respectively.  asdcp-util contains the remaining functions. Note that
   asdcp-test is now DEPRECATED, new functionality and bug fixes will be
   aimed at the new tools.  Also note that some options and calling
   conventions are different for the new tools as compared to asdcp-test.
   Please read the synopses and make sure you understand the new idioms.
 * asdcp-wrap has a new argument, ```-C <UL>```, that writes the given UL to the
   ChannelAssignment item in the WaveAudioDescriptor (only useful when
   writing PCM essence).


> **2011-11-30 - bug fixes v1.8.44**
 * Corrected a wrong decryption UL selection when unwrapping MXF.


> **2011-10-27 - bug fixes v1.8.43**
 * Corrected broken Essence UL matching. (Thanks to Michael Loder).


> **2011-08-31 - bug fixes v1.8.42**
 * Added missing HFR support for PCM essence reader/writer.


> **2011-08-30 - bug fixes, enhancements v1.8.41**
 * UL version byte now ignored when comparing UL values.
 * Changed the version byte in the TimedTextEssence UL to 0x01.  There
   is no published Essence Keys registry so it can't have a maintained
   version number.
 * JP2K Sequence Parser modified to skip directory entries that
   are not files in the case where the parser is initialized with
   a directory path.  When initialized with a list of file names
   this check is not performed.  Based on a hint by Steve Quartly.
 * Increased the size of the MPEG header parser buffer.
 * Added missing FrameType() implementation to ASDCP::MPEG2::MXFReader.
 * Added missing Close() implementations to MXF reader classes.
 * Added missing Timestamp::Timestamp(const char* datestr) implementation.
   (Thanks to Matt Sheby for this and the previous three items.)
 * Fixed error in Kumu::FortunaRNG::FillRandom() that was returning the
   end of the random buffer instead of the front (Thanks to Mike Radford).
 * Added support for proposed sound channel format identifiers
   '7.1DS' and 'WTF'.  Optimistically chose version '0x0c'.
 * Added support for stereoscopic images in JP2K files at edit
   rates of 48, 50 and 60 eups (96, 100 and 120 fps).


> **2010.11.15 - bug fixes, enhancements v1.7.40**
 * Fixed bug in long KLV packet support (Thanks to Jim Radford).
 * Fixed AvgBps in PCM files, *again*. Sorry for the crazy.
 * More fixes and changes in support of 25, 30, 50, 60 fps.
   (Thanks to Hans K. for the TC rate bug).
 * Updated KLVFill UL version element to 0x02.
 * Type change to support Xerces-C 3.x. (Thanks to Matt Sheby).
 * Some internal API changes to KLV types. Does not affect
   operation.
 * Added NetworkLocator type to MXF metadata types.
 * Added file offset display to klvwalk.


> **2010.09.09 -  bug fixes, enhancements, v1.7.39**
 * Fixed bug in JP2K PictureDescriptor initialization in
   JP2K::MXFReader::OpenRead() and JP2K::MXFSReader::OpenRead()
 * Once again fiddling with AvgBbs. How can something so simple
   be such a constant cause of trouble? Tested with 1-, 2- and
   6-channel input Wav files.
 * asdcp-test now accepts a directory name when making PCM
   files (-c). The directory name should be the only filename
   argument. All files in the directory must be Wav files
   (mixed channel sizes OK). Files are sorted alphabetically by
   filename. Hint: use numeric name infix to define order:
   my_movie_00_L.wav
   my_movie_01_R.wav
   my_movie_02_C.wav
   my_movie_03_LFE.wav
   my_movie_04_LS.wav
   my_movie_05_RS.wav


> **2010.07.20 -  bug fixes, v1.6.37**
 * Fixed TimedTextResourceSubDescriptor UL value.


> **2010.06.16 -  bug fixes, v1.6.36**
 * Added support for new Edit Rates to asdcp-test.cpp.
 * Expanded timed-text file reader in asdcp-test.cpp.
 * Fixed large BER value encoding (plaintext) and decoding
   (plaintext and ciphertext). This feature was introduced in
   v1.5.31).
 * Fixed AvgBps value for multi-channel Wave input.


> **2010.05.13 -  bug fixes, enhancements, v1.6.34**
 * ST 429-5 files have corrected ULs for DCTimedTextDescriptor and
   GenericStream DataElement. Files made with previous versions of
   the library are incompatible with this and future versions.
 * Fixed File Package TrackNumber values. Th
anks to Sankar.
 * Added edit rate constants to AS_DCP.h (25, 30, 50, 60).
 * Changed AudioDescriptor "SampleRate" element name to "EditRate"
   to make it consistent with the other types.
 * Now builds with XercesC 3.x.
 * KM_memio.h has better const behavior.
 * Fixed a bug in KM_memio.h string archiving.


> **2010.01.05 -  bug fixes, enhancements, v1.5.32**
 * Re-fixed swapped Interop and SMPTE OP Atom UL values. The swap
   introduced in v1.5.31 was done in error.
 * Added -z,-Z options to asdcp-test (j2c parameter checking)
 * Reformed jp2k-test as j2c-test, added help and list processing,
   added to standard install target.


> **2009.12.31 -  bug fixes, enhancements, v1.5.31**
 * Fixed swapped Interop and SMPTE OP Atom UL values.
 * Added get_BER_length_for_value() subroutine.
 * Modified ASDCP::h__Writer::WriteEKLVPacket() to allow larger BER
   lengths for KLV packets larger than 16 MB. This was required to
   support large font files in the SMPTE 429-5 implementation.


> **2009.11.06 - bug fixes, enhancements, v1.5.29**
 * Fixed a bug that could cause HMAC values to be incorrectly
   stored in MXF files.  Files created with versions of asdcplib
   prior to this version may have incorrect HMAC values. 
 * Improved handing of XML files for MXF wrapping.  
 * Jpeg2000 codestream EditRate and SampleRate mismatches
   now warns instead of returning an error. 
 * Improved error handling in Jpeg2000 sequence parsing routines.  
 * Added two methods to Kumu::Timestamp, AddSeconds(), to add (or
   subtract) seconds to a time value, and GetSecondsSinceEpoch()
   to get the number of seconds since the unix epoch.
 * Added new option to asdcp-test, '-a', to specify a UUID when
   creating MXF files.
 * Added support for specifying the intrinsic duration of MXF files
   containing timed text.
 * Added new option to wavesplit, '-i', to display WAV file metadata.


> **2009.05.21 - bug fixes, v.1.4.24**
 * Fixed a bug that caused incorrect SubDescriptors UL values to be 
   written into interop format MXF track files.  Note that this involved
   a substantial reorganization of MXF internals.  Please test thoroughly
   in your application before using in production.  Note that this is a 
   significant bug fix and track files created with 1.4.22 may be incompatible
   with other systems.  


> **2009.04.09 - SMPTE format fixes, enhancements and bug fixes, v.1.4.22**
 * asdcplib now uses GNU autotools on POSIX systems to configure 
   and build.  See "./configure" for details.  Note that two options, 
   --enable-freedist and --with-python are not enabled in the free
   version of asdcplib and should not be used.  
 * Added build option (CONFIG_RANDOM_UUID) to enable mixed case UUID
   generation when environment variable KM_USE_RANDOM_UUID is defined.
 * Fixed a condition that could cause an error to occur when wrapping 
   SMPTE format timed text track files that do not define a starting 
   frame.
 * Updated ULs for SMPTE format track files.
 * SampleRate added to JP2K metadata
 * Support for wrapping 96kHz WAV files added.
 * Updated ULs for audio channel formats  (ChannelFormat)  
 * Updated font subdescriptor MIME Types for TimedText Trackfiles.
 * Changed time implementation to support dates beyond Jan 19th, 2038.
 * Xerces-C XML parser support added.  
 * New build method for Windows (see win32/README.txt for details).
 * Added new functionality in Kumu to recursively create and delete files 
   and directories, and get free disk space for a given volume path.
 * Added a method to Kumu::Timestamp, AddMinutes(), to add (or subtract) 
   minutes to a time value.  
 * Improved how Kumu::Timestamp parses timestamps with offsets. 
 * Fixed a bug that caused incorrect HMAC values to be calculated.


> **2008.02.16 - SMPTE format fixes, bug fixes v.1.3.18**
 * Added correct SMPTE UL for StereoscopicPictureSubDescriptor.
 * Exposed JP2K metadata parser as ParseMetadataIntoDesc().
 * Added simple stereoscopic framebuffer to support paired ReadFrame()
   and WriteFrame() methods (allows simpler integration with other
   single-buffer code).
 * Improved detection of JPEG Interop stereoscopic files.
 * Win32 build fixes (Thanks to Mike Crowe at DTS).
 * Added the WITH_MD macro to the makefile. Set this value to one
   to build Win32 with /MD[d] instead of /MT[d].
 * The Generic Container UL has been added to the EssenceContainers
   set in the header partition pack for encrypted files. It has always
   been there in plaintext files.
 - Below this point the changes are internal and should not affect you
   unless you use Kumu directly.
 * Major refactoring of KM_log.[h|cpp].
 * Fixed buffer re-sizing issue in Kumu::ByteString.
 * Replaced type IdentifierList with ArchivableList.
 * Added COPYING file to the release bundle.


> **2007.12.13 - Bug fixes v.1.2.17**
 * Changed Result_t implementation to use int instead of long, which
   was causing trouble on some 64 bit platforms.
 * Fixed EKLV HMAC. NOTE: Breaks backward compatibility with older
   Interop files. To validate these files, use asdcplib-1.1.14. This
   should not cause too much trouble since files with broken and
   non-broken HMAC have been in the wild for years without issue.
 * Fixed HMAC sequence numbering in encrypted stereoscopic files.
 * Finished stereoscopic test targets in the makefile.
 * Fixed the win32 build, now expects VS2005 compiler by default,
   use WITH_VC6=1 top get VC6 flags.
 * Stereoscopic and Timed Text modes now have SMPTE UL values.
   NOTE: SMPTE 429-5 and 429-10 are not yet published. It is possible
   that these UL values may change before publication. Please use
   caution when using these features for production work.
 * Changed a bunch of symbol names in the 429-5 implementation to
   better match the spec.
 * Added -U option to asdcp-test to dump the UL library to stdout.
 * Fixed erroneous placement of the PictureEssenceCoding UL in JP2K
   files (Interop and SMPTE modes).


> **2007.10.22 - Timed Text, Stereoscopic Picture and Bug fixes v.1.2.16**
 * Significant API changes have been made. Please read all entries
   in this changelog to be sure you understand the changes. Also
   note that some changes have been made to LS_MXF_SMPTE files that
   are incompatible with earlier releases (e.g., EKLV HMAC). If
   you are looking for a stable interop release, use  v.1.1.14.
 * Fixed RFC 2104 HMAC implementation for LS_MXF_SMPTE only. The
   broken implementation has been maintained for Interop mode.
 * Added support for draft SMPTE 429-5 Timed Text Track File. This
   is still waiting for official SMPTE ULs, so do not use it for
   shipping products.  An XML parser is needed to create a Timed
   Text Track File; Expat is now an optional part of the build.
   Make with WITH_XML_PARSER=1 to link with Expat. If you do not
   link with expat, you will get an error when using the TimedText::
   DCSubtitleParser class. See also S429-5-cgi.cpp for an example
   that shows how to serve plaintext MXF file elements directly via
   HTTP.
 * Added support for draft SMPTE 429-10 Stereoscopic Picture Track
   File, including the JPEG Interop version. This is still waiting
   for official SMPTE ULs, so do not use it with LS_MXF_SMPTE for
   shipping products.  
 * Refactored the following files as a side-effect of the above
   work: AS_DCP_JP2K.cpp AS_DCP_MPEG2.cpp AS_DCP_PCM.cpp
   AS_DCP_MXF.cpp AS_DCP_internal.h MXF.[h|cpp] MXFTypes.[h|cpp]
   Metadata.[h|cpp] h__Reader.cpp h__Writer.cpp klvwalk.cpp.
   WARNING: While significant effort has been extended to make sure
   that these changes do not affect existing stable file support,
   users are cautioned to test this release thouroughly.
 * Added a large set of filesystem path manglers to KM_fileio.h. See
   path-test.cpp for example usage. The path manglers have not yet
   been tested on win32 platforms (they are currently used only by
   the Timed Text module.
 * The PathIsFile(), PathIsDirectory() and FileSize() subroutines
   have been modified to accept const std::string& instead of
   const char*.
 * Added namespace and parsing support (Expat) to Kumu::XMLElement
   (currently used only for Timed Text support). Also added some
   new accessors.
 * Altered MXF::UTF16String to use mbtowc() and wctomb().


> **2007.03.31 - Bug fixes v.1.1.14**
 * Fixed KeyFrameOffset value in MPEG wrapping to have negative
   value. This is probably not yet complete for handling all
   types of GOPs. Please send chunks of MPEG-2 VES that you
   find which break this. Thanks to Doremi.
 ** no other file format changes in this release **
 * Fixed error in RIP interpretation when reading arbitrary (i.e.,
   non-MXF) files.
 * Fixed a memory leak in ASDCP::MXF::OPAtomHeader when used
   in read mode. Thanks to Mahesh Bajaj for pointing out this
   bug and the one above.
 * Removed asserts from KM_fileio, replaced with RESULT_WRITEFAIL
   return value statements.
 * Added -s and -p to the makefile install target.
 * Altered ByteString behavior to use target Length() in copy
   operations (instead of Capacity()).
 * Added new Set() method to ByteString.
 * Fixed a bug in ByteString::Unarchive() that caused the operation
   to fail when the buffer was smaller than the read (i.e., when
   Capacity() was called).
 * Added IdentifierList class to KM_util.h.
 * Changed some Error() messages to Debug() in Wav.cpp
 * Revived jp2k-test.cpp and asdcp-mem-test.cpp (they both had
   stale #includes).


> **2007.02.15 - Bug fixes v1.1.13**
 * Removed 'VDescObj->SampleRate.Numerator = VDesc.FrameRate;'
   from MPEG2_VDesc_to_MD() in AS_DCP_MPEG2.cpp, was line 76.
 * Added KM_TEST_NULL_STR_L() and KM_TEST_NULL_L() macros to
   KM_log.h. These versions log the location of the null value.
   Macros are now used in any module that includes KM_log.h.
 * MPEG2 VES with run of zero values at the head is now OK.
 * Increased VESHeaderBufSize to 16K.
 * Added makefile support for local OpenSSL in ../openssl, if
   present.
 * The Kumu::PathIs*() functions now return false if a null or
   empty string is given (used to be an assert).
 * Cleaned up the install target in the makefile.
 * Fixed SMPTE 429-6 HMAC -- FIPS 186-2 implementation was
   laughably incorrect. Thanks to Doremi for pointing this out.
 * Removed default parameter to HMACContext::InitKey().
 * Cleaned up messages and CLI arg handling in asdcp-test.


> **2006.11.19 - Mo better stuff v1.1.12**
 * Changed read-only Result_t accessor methods to const.
 * Added Base64 (-B) option to kmrandgen.
 * Removed 16-bit alignment restriction from kmrandgen.
 * Improved WAV file extraction speed (Thanks to Jim Radford
   for pointing this out).
 * Added single-channel split for WAV extraction (asdcp-test -1).
 * Fixed remainder bug in h__RNG::fill_rand().


> **2006.11.03 - Bug fixes v1.1.11**
 * Increased index table entry list size to 5000.
 * Added length checking to TLV writer (returns error if TLV
   payload exceeds 64kB).
 * Fixed partition header and RIP errors related to 2-partition
   files (MXF Interop mode).
 * Added -t option to asdcp-test (SHA-1 digest with Base64 output
   on stdout).
 * Fixed Sub Descriptor reference bug (Thanks to Denis Leconte
   for dogged determination).
 * Added directory-of-wav detection to RawEssenceType()
 * Modified MXF::Partition::AddChildObject() to only generate
   a UUID if the InstanceID is unset.
 * Added ComponentMaxRef & ComponentMinRef to RGBAEssenceDescriptor.
   More to follow.
 * Added detection of 2K/4K jp2c, writing correct 4K metadata.


> **2006.10.05 - Bug fixes v1.1.10**
 * Changed RM_RELEASE to RL_RELEASE in MXFTypes.h.
 * Changed the MXF writer to use RL_RELEASE (was RL_DEVELOPMENT).
 * Really fixed source reference chain.
 * Updated JP2K file package label.
 * Changed location of JPEG2000PictureSubDescriptor in the
   header (was erroneously before Preface).
 * Altered LS_MXF_INTEROP to produce 2-partition files.


> **2006.09.25 - Bug fixes v1.1.9**
 * Fixed SourcePackageID value. All files will be 'original',
   i.e. SourcePackageID will be all zeros. Let me know if you
   want to set SourcePackageID.
 * Fixed compiler warnings on some Linux platforms
 * Fixed the build so that BUILD_DIR is no longer created
   as a dependency.
 * Added duration detection to the raw essence parsers. The
   MPEG parser uses a nasty approximation so don't use it
   without paying close attention to the result.
 * Modified PCMParserList to make it more useful as a base
   class.
 * Fixed bugs and re-organized command-line help in asdcp-test
   and klvwalk.
 * Fixed two-partition file reads.
 * Fixed Win32 PRNG initialization.
 * Renamed asdcp-lf-test as kmfilegen.
 * Added kmrandgen and kmuuidgen.
 * Added string retrieval mechanism to Result_t.
 * Refactored Kumu::Identifier and its sub-classes.
 * Altered Kumu::PathIsFile to return true when the path
   is a symbolic link (unix only).
 * Altered Kumu::FileWriter::OpenWrite to use file creation
   mode 0664 (was 0644) (unix only).
 * Added Kumu::WriteStringIntoFile() subroutine.


> **2006.04.05 - Bug fixes and new stuff v1.1.7**
 * Fixed a bug in the MPEG parser that caused it to fail when
   handling start codes spanning buffer boundaries
 * Added wavesplit and blackwave utility programs
 * Added support for revised SMPTE HMAC key derivation when
   using LS_MXF_SMPTE
 * Refactored platform compatibility and general utilities
   into a new sub-library "Kumu". There are no new build
   steps or dependencies, but some important things have
   changed:
   + Result_t is no longer an enum, it is now a class.
     Library result codes are now declared as const objects
     like this:  
     ```
     const Kumu::Result_t RESULT_FORMAT (-101, "The file...");
     ```
     The macros ASDCP_SUCCESS and ASDCP_FAILURE still work
     the same way thanks to an operator overload for type long.
     See KM_error.h for more information.
   + The logging interface has been moved out of AS_DCP.h
     and into KM_log.h
 * Some of the command line utilities that were using headers
   other than AS_DCP.h have been changed to use the Kumu
   equivalents. If you have code based on those utilities, you
   will have to update by hand.
 * Added new types to the EssenceType_t enum.
 * The guard macro for Win32 code has changed from WIN32 to
   KM_WIN32.


> **2006.03.2x - new stuff**
 * Proper handling of stream-id byte of essence UL values
 * writes 3-partition files, reads 2-part or 3-part


> **2006.03.16 - bug fixes plus**
 * Removed SMPTE_LABELS compile-time option. The reader will now
   silently accept either SMPTE or MXF Interop labels, the writer
   can be instructed which to use at runtime. Default is Interop.
 * Added an AIFF reader. Support is preliminary, it works with the
   AIFF files I have on hand.
 * More code refactoring. More to come.


> **2006.03.09 - full read-write**
 * Removed ASDCP_WITHOUT_OPENSSL compile-time option.
 * Full read/write now working on new MXF library


> **2005.00.00 - A New Hope**
 * The temporary mxf-lite has been removed. MXF files are now 
   managed via the objects in KLV.h, MXFTypes.h MXF.h and
   Metadata.h. This release does not support writing MXF files.
 * Fixed a header interpretation error in the Wav parser.


> **2005.00.00 - The Reformation**
 * Removed mxflib as a dependency by forking the necessary
   functions and placing them in the mxf-lite subdirectory.
   Please note that the very heavy modifications done here
   render all comparisson to mxflib code a substantial task.
   All errors are now mine and users are warned not to bug
   Oliver or Matt for help with this code. The version of
   mxflib at the time of the fork was: 0.5.1.3.


> **2005.06.03 - bug fixes v0.10.18**
 * Updated UL batch to include GC UL.


> **2005.05.27 - bug fixes v0.10.17**
 * Un-did essence container and compression descriptor changes.
   The default build reflects MXF Interop decisions as of 26 May.
 * Added note about build versions to README (see above).
 * Added warnings to SMPTE_LABELS builds.
 * Fixed JP2K essence container label.


> **2005.05.02 - bug fixes v0.10.16**
 * Reorganized internal files, added file reader object, added OS
   portability header, removed and renamed some files. If you have a
   patch against previous versions of the source, you should check
   it thoroughly.
 * Added RGBA attributes to JP2K descriptor.
 * Changed interface to CodestreamParser.
 * Added JP2K parser implementation. It is parsing each frame but is
   not yet being used to populate the descriptor.
 * Added 48fps option for `asdcp-test -p`.
 * Added picture rate constants to AS_DCP.h (23.976, 24, 48).
 * Added sample rate constant to AS_DCP.h (48k).
 * Changed asdcp-test to encrypt picture headers by default
   (plaintext offset will be 0), added -E option to allow
   plaintext headers.


> **2005.04.28 - bug fixes v0.9.15**
 * The XML descriptors for the crypto DMS have moved in mxflib to
   the file DMS_Crypto.xml (they were in DMS_DCPENC.xml).  Older
   installations should update the file from mxflib.
 * Added Close() and Seek() to ~MyFileWriter(), cleaned up headers
 * Added UUID generator output mode (-u).
 * Added -S option to extract PCM essence into stereo wav files
 * Added more UL testing and conformance checking.
 * Added macro SMPTE_LABELS which causes the library to be built
   with SMPTE (as opposed to MXF Interop) labels. This is not
   set by default, and currently only affects the PCM container
   label and encrypted element label.
 * Cleaned up the GNUmakefile test targets, the source files
   are now named with the TEST_FILE_PREFIX macro.
 * enabled 23.976-framed PCM (2002 samples per frame)
 * The size of the asdcp-test frame buffer for picture essence
   may now be set from the command line (-b).  The default is 4MB.
 * h__Reader::ReadEKLVPacket() now tests the UL (duh) and switches
   on the value, allowing plaintext and ciphertext frames to
   be mixed in the file.
 * Fixed error in UUID generator format.
 * JP2K files now use the GenericPictureDescriptor to store
   ContainerDuration and SampleRate. SampleRate is mapped
   to EditRate in the PictureDescriptor struct. This fixes
   the second caveat from the 0.8.13 release.
 * Fxed bug in PCMParserList that was miscalculating the extent
   of a PCM sample.  This bug did not affect API users, it was
   only present in asdcp-test.
 * Fixed EditRate on PCM files (was showing sample rate)
 * Fixed Encrypted Essence Container UL
 * Fixed BlockAlign value for PCM essence
 - The following changes were provided by Jeff Loewenguth
 - Thanks Jeff!
 * Moved the DMS CryptographicFramework entry from the material
   package to the source package
 * Fixed erroneous Source Essence Container Label value
 * Fixed broken sort of JP2K frames in JP2K parser
 * Added FindFrameGOPStart() method to the MPEG2 MXFReader
 * Added missing length values for EKLV packets without HMAC
 * -x with JP2K essence writes to files with 6 digit names
   (up from 5 digits).
 * The Key ID may now be specified as an argument to asdcp-test
    (-j <key-id-string>)


> **2004.12.30 - bug fixes + wav files v0.8.14**
 * Added WAV file write to asdcp-test (uses mxflib::waveheader_t).
 * Three-partition files reading properly.  adscplib still writes
   two-partition files.
 * Changes in the mxflib WAV essence parser API had broken
   asdcplib's ability to read essence from a WAV file.  I have
   fixed this bug, but at the expense of breaking compatibility
   with older versions of mxflib. Beware!
 * Removed redundant (but working) bin-text-bin conversions.


> **2004.12.23 - JPEG 2000 support v0.8.13**
 * Reads/writes JPEG 2000 essence in plaintext and ciphertext
   with the following caveats:
    - The Picture Essence Descriptor is empty.
    - Because there is no essence descriptor, the reader code
      in asdcp-test has no idea how many frames are in the file
      and ends with an out-of-bounds frame error.  This error
      is being suppressed in asdcp-test for the current release.
 * Still broken when reading three-partition files.


> **2004.10.22 - fixes and UL updates v0.7.11**
 WARNING: COMPATIBILITY BREAKPOINT
 Files created with this and future versions of this library are
 not compatible with previous versions of this library.  As you
 might suspect, files created with previous versions of this
 library are not compatible with  this and future versions.
 * h__Reader will now open a three-partitition file (untested)
 * Moved DMS from Material partition to File partition
 * Added length fields to appropriate places in EKLV packet 


> **2004.10.22 - fixes and UL updates v0.7.10**
 * fixed frame buffer handling of externally allocated buffer,
   created unit test (asdcp-mem-test)
 * added operator==() and operator!=() to Rational type
 * fixed some type-related compiler warnings
 * asdcp-test -p now works on unwrap
 * updated some ULs to match documentation (thanks to Arun
   for the submission)
 * canonicalized line endings


> **2004.07.02 - full plaintext + ciphertext read/write v0.6.9**
 * HMAC, plaintext offest and raw ciphertext read supported
 * back to proper CBR index
 * MPEG temporal offset working


> **2004.07.01 - plaintext + ciphertext read/write v0.5.8**
 * encryption of MPEG and PCM essence supported with the
   following caveats:
   - no HMAC support
   - no plaintext offest support
   - no raw ciphertext read support
 * moved to reflecting the whole KLV triplet in the CBR
   index (now incompatible with mxflib, still searching
   for info about what's "right")
 * awaitng the following fixes/features:
   - retrieve Temporal Offset from index in MPEG2::Reader
   - test for correct ULs when reading frame triplets
   - fix header metadata items for encrypted files
   - HMAC support
   - plaintext offest support
   - raw ciphertext read support


> **2004.06.14 - plaintext read/write w/key generator v0.4.5**
 * Project now uses OpenSSL (tested with 0.9.7d on win32, Linux, Darwin)
   Use `make ASDCP_WITHOUT_OPENSSL=1` to make plaintext-only version
 * Accepts interior I frames when parsing MPEG2 VES
 * Improved error reporting on format errors
 * Added support for encryption to asdcp-test
 * Added RNG for asdcp-test (non-production use only, see notes in FortunaRNG.h)
 * Implemented CBC encrypt, decrypt module
 * Added partial TemporalOffset retrieval from MPEG2 parser
 * Fixed win32 binmode bug


> **2004.05.12 - plaintext read/write v0.3.4**
 * Full read/write of plaintext MPEG-2 VES and WAV files
   (does not yet support mux from or demux to 2 channel pairs)
 * Builds with autoconf-based mxflib
 * Added ASDCP_ prefix to macros
 * Updated documentation, fixed documentation errors
 * Simplified API for MXF writer setup
 * Decoupled essence parsers from MXF writers
 * added raw ciphertext support to FrameBuffer
 * Cleaned up Get/Set naming confusion
 * Added missing const qualifiers


> **2004.04.27 - preview release v0.2.1**
 * hasty release for quick review
 * this release may not build with mxflib using autoconf.
 * writes plaintext AS-DCP MPEG2 essence files
 * tested under win32 and linux. FreeBSD and Darwin do not work


> **2004.02.04 - First release (v0.1.1):**
 * asdcp-test is mostly complete. It should correctly provide
   access to the read and info capabilities of the library.
 * The MPEG2 reader is functional but not fully tested.
 * Some file format integrity tests remain to be coded.
 * The PCM reader is mostly complete, I am having difficulty
   getting a suitable test file from mxfwrap.
 * The makefile creates a static library module. The API
   will cleanly support a DSO (or DLL). Let me know if DSO
   support is important to you.
 * Nothing is thread safe. Thread safety was not a requirement
   in the initial project definition. Thread safety may be added
   above the mxflib/klvlib level. Let me know if it is important
   to you.
 * The files xmldict.xml and types.xml must be in the current
   directory when the program is run. The files are supplied
   with mxflib. Runtime location of the files is not currently
   a project goal. Comments on how best to handle this situation
   would be appreciated. See AS_DCP.cpp at init_mxf_types()
   for a more detailed discussion.

--


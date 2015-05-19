---
layout: default
title: Description of RPM file format
---
# Description of RPM file format

## NOTE That this is a draft, and does not perfectly match existing RPM format

## 1. Introduction

### 1.1. Purpose
The purpose of this specification is to define an encapsulation file format that contains data and metadata that:

* Is independent of CPU type, operating system, file system, and character set, and hence can be used for interchange;
* Can be implemented readily in a manner not covered by patents, and hence can be practiced freely;
* Is compatible with the file format produced by the current widely used rpm utility, in that conforming consumers will be able to read data produced by the existing rpm producer. 

The data format defined by this specification does not attempt to:

* Provide semantic definitions for use of the format
* Create world peace 

### 1.2. Intended audience

This specification is intended for use by implementors of software to product files in rpm format and/or consume files in rpm format.

The text of the specification assumes a basic background in programming at the level of bits and other primitive data representations.

### 1.3. Scope

    XXX: FIXME

### 1.4. Compliance

Unless otherwise indicated below, a compliant consumer must be able to accept and decompress any file that conforms to all the specifications presented here; a compliant producer must produce files that conform to all the specifications presented here. The material in the appendices is not part of the specification per se and is not relevant to compliance.

### 1.5. Definitions of terms and conventions used

byte: 8 bits stored or transmitted as a unit (same as an octet). (For this specification, a byte is exactly 8 bits, even on machines which store a character on a number of bits different from 8.) See below for the numbering of bits within a byte.

### 1.6. Changes from previous versions

There have been no previous versions of this docuent.

## 2. Detailed specification

### 2.1. Overall conventions

In the diagrams below, a box like this:
<pre>
                     +---+
                     |   | <-- the vertical bars might be missing
                     +---+
</pre>
represents one byte; a box like this:
<pre>
                     +~~~~~~~~~~+
                     |          |
                     +~~~~~~~~~~+
</pre>
represents a relatively large fixed number of bytes; a box like this
<pre>
                     +==============+
                     |              |
                     +==============+
</pre>
represents a variable number of bytes.

Bytes stored within a computer do not have a "bit order", since they are always treated as a unit. However, a byte considered as an integer between 0 and 255 does have a most- and least- significant bit, and since we write numbers with the most- significant digit on the left, we also write bytes with the most- significant bit on the left. In the diagrams below, we number the bits of a byte so that bit 0 is the least-significant bit, i.e., the bits are numbered:
<pre>
                     +--------+
                     |76543210|
                     +--------+
</pre>
This document does not address the issue of the order in which bits of a byte are transmitted on a bit-sequential medium, since the data format described here is byte- rather than bit-oriented.

Within a computer, a number may occupy multiple bytes. All multi-byte numbers in the format described here are stored with the most-significant byte first (at the lower memory address). This is known as network byte order[x]. For example, the decimal number 520 is stored as:
<pre>
                         0        1
                     +--------+--------+
                     |00000010|00001000|
                     +--------+--------+
                      ^        ^
                      |        |
                      |        + less significant byte = 8
                      + more significant byte = 2 x 256
</pre>

### 2.2. File format

A rpm file consists of four sections: a "lead", a signature "header", a payload "header", and a "payload" (the actual data). Both header sections have the same format. The format of each of these is specified in the following sections. Each of the sections appears one after another in the file, with no additional information before, between, or after them.

### 2.3. Lead format

The lead has the following structure:
<pre>
                     +---+---+---+---+---+---+---+---+---+---+
                     |M1 |M2 |M3 |M4 |MAJ|MIN| TYPE  | ARCH  | (more -&gt;)
                     +---+---+---+---+---+---+---+---+---+---+

                     +~~~~~~~~~~~~~~~~~~+---+---+
                     | 66 bytes of NAME |OS |SIG| (more -&gt;)
                     +~~~~~~~~~~~~~~~~~~+---+---+

                     +~~~~~~~~~~~~~~~~~~~~~~+
                     | 16 bytes of RESERVED |
                     +~~~~~~~~~~~~~~~~~~~~~~+
</pre>

### 2.3.1 Field Definitions

M1 (Magic 1) M2 (Magic 2) M3 (Magic 3) M4 (Magic 4)
: These have fixed values M1 = 0xed, M2 = 0xab, M3 = 0xee, M4 = 0xdb, to identify the file as being RPM format.

MAJ (Major version) MIN (Minor version)
: These designate the version of the file format. This document describes major version 3 of the format. This is the second revision of version 3, so the minor version is 1. Major versions 1 and 2 do not use the same format, and are not currently documented. Major version 4, Minor version 0 and Major version 3, Minor version 0 use an identical file format to that which is here described.

TYPE
: This designates the file type. It is implementation defined and should be set to 255 (0xFF) unless otherwise required.

ARCH
: This designates the platform architecture the file is intended for. It is implementation defined, and should be set to 0 unless otherwise required.

NAME
: The name area contains Unicode 3.2.0[x] or later text using the UTF-8[x] encoding. It must be normalized in Normalization Form C (NFC)[x]. All unused bytes must be filled with 0. It must be a valid UTF-8 string.
: I would prefer Unicode 4.0 or later to be specified, but Python appears to still be on 3.2.0.

OS
: This designates the OS the file is intended for. It is implementation defined should be set to 0 unless otherwise required.

SIG (Signature version)
: This designates the signature version used on the file. This document describes signature version 5. Versions 1, 2, 3 and 4 do not use the same format, and are not documented.

RESERVED
: This is reserved for future use. It should be filled with zeros.

### 2.3.2 Compliance

A compliant producer must use Major version 3, Minor version 1, and Signature version 5. It must fill RESERVED with zeros. It must have the correct values for M1, M2, M3, and M4. It must set TYPE, ARCH, and OS to 255, 0, and 0 respectively. It must only put a valid UTF-8 string in NAME.

A compliant consumer may only accept Major versions 3 and 4. It may only accept Minor version 0, or Minor version 1 with Major version 3. It must accept Major version 3, Minor version 1. It must verify the correct values for M1, M2, M3, and M4. It must ignore the values of RESERVED, TYPE, ARCH, and OS. It must accept Signature version 5. It may only accept Signature version 5. It must accept any valid UTF-8 string for name.

## 2.4. Header format

The header has a header lead, followed by index entries, then the actual data. It has the following structure:
<pre>
                     +---+---+---+---+---+---+---+---+---+---+---+---+
                     |HM1|HM2|HM3|VER|   RESERVED    |  INDEXCOUNT   | (more ->)
                     +---+---+---+---+---+---+---+---+---+---+---+---+

                     +---+---+---+---+===============+============+
                     |   STORESIZE   | Index Entries | Data Store |
                     +---+---+---+---+===============+============+
</pre>

### 2.4.1 Field Definitions

HM1 (Header Magic 1) HM2 (Header Magic 2) HM3 (Header Magic 3)
: These have fixed values HM1 = 0x8e, HM2 = 0xad, HM3 = 0xe8 to identify the header uniquely.

VER (Version)
: This is the version of the header. This document describes header version 1. No other header versions are defined at this time.

RESERVED
: These bytes are reserved for future used, and should be filled with zeros.

INDEXCOUNT
: This is the number of header index entries.

STORESIZE
: This is the total size, in bytes, of the data store.

### 2.4.x Header Index entry format

Each header index entry has the following structure:
<pre>
                     +---+---+---+---+---+---+---+---+---+---+---+---+
                     |      TAG      |     TYPE      |     OFFSET    | (more ->)
                     +---+---+---+---+---+---+---+---+---+---+---+---+

                     +---+---+---+---+
                     |     COUNT     |
                     +---+---+---+---+
</pre>
### 2.4.x Field definitions
TAG
: This is a number which identifies the context of the data.

TYPE
: This identifies the format of the data. There are eight defined types: Type Number Description 0 Null 1 Character 2 8-bit Integer 3 16-bit Integer 4 32-bit Integer 5 64-bit Integer 6 String 7 Binary Data

: Additionally 8, 9, 10, and 11 are reserved for compatibility reasons.

: Type numbers greater than 32767 are reserved for future use. Type numbers between 24576 and 32767, inclusive, are for private use and definition may vary between implementations.

: Should we have a binary data array type?

OFFSET
: Position of the data in the store.

COUNT
: For binary data, then number of bytes. For all other types, the number of data items associated with the index entry.

### 2.4.x Defined Tags

For the payload header, there are two tag numbers that are defined.

1124 - Payload Format
: The payload format is a string which defines the format. It is always a string type (6) and has a count of 1. Currently only the value "cpio" is defined.

1125 - Payload Coding 
: The payload coding is used to indicate an encoding transformation that has been applied to the payload. It is always a string type (6) and has a count of 1. Currently three encodings are defined: "none", "gzip", and "bzip2".

Reserved
: Tag numbers greater than 32767 are reserved for future use

Private Use
: Tag numbers between 24576 and 32767 inclusive are for private use and their definition may vary between implementations.

### 2.4.x Payload Formats

If the payload format is not specified via the 1124 (Payload format) header entry, then it is assumed to be "cpio".

cpio
: I can't find a standard for CPIO format that is published, expect POSIX.1 which does not document the CPIO format used by RPM.

: FIXME: Document the new ASCII and CRC CPIO formats and reference here.

### 2.4.x Payload Codings

If the payload coding is not specified via the 1125 (Payload coding) header entry, then it is assumed to be "gzip". The "passthrough" mode feature of zlib is used to allow the lack of the 1125 (Payload coding) header entry to also represent "none".

none
: FIXME: define none, note that current RPM implementations do not explicitly handle this, but I think it will work

gzip
: FIXME: define gzip

bzip2
: FIXME: define bzip2

### 2.4.x Compliance

A compliant producer must only use header entries with types defined in this document that are not reserved. It must not create more than one payload format and one payload coding header entry in the payload header. Headers data must not overlap in the store. Any unused bytes in the data store must be set to 0.

A compliant consumer should accept multiple header entries with the same tag in a single header section.

## Appendix: RPM Compatibility

Header entry types 8 and 9 have been used for strings in the past. They are processed identically to the string type (6).

In file format 3, as documented in Maximum RPM, the string type could only have a count of 1. There was a String Array type, assigned the value of 8, which was used for entries with multiple strings. There was also an internationalized string type, assigned the vlaue of 9, which was functionally identical to a string array. There was a specifically paired tag which contained a list of languages in the same order as the strings.

Header entry types 10 and 11 were added to store ASN1 and OpenPGP data. They are processed identically to the binary data type.


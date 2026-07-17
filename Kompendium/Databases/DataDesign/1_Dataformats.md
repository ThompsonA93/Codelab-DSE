# Data formats

- [Data formats](#data-formats)
  - [Structured Data](#structured-data)
    - [Comma-separated values (CSV)](#comma-separated-values-csv)
  - [Semi-Structured Data](#semi-structured-data)
    - [Javascript Object Notation (JSON)](#javascript-object-notation-json)
    - [Extensible Markup Language (XML)](#extensible-markup-language-xml)
  - [Unstructured Data](#unstructured-data)
    - [Markdown (MD)](#markdown-md)
    - [Portable Network Graphic (PNG)](#portable-network-graphic-png)
    - [Waveform Audio File Format (WAV)](#waveform-audio-file-format-wav)


## Structured Data

Data stored in **Rows** (Individuals) **and** **Columns** (Attributes)

### Comma-separated values (CSV)

```csv
ID,Title,Genre
1,"Dune, Part One","Science Fiction"
2,"A Brief History of Time","Non-Fiction"
3,"The Name of the Wind","Fantasy"
```

## Semi-Structured Data

Data stored within **hierarchical structures**


### Javascript Object Notation (JSON)

```json
{
  "LibraryName": "City Central",
  "Branches": [
    {
      "BranchID": "A",
      "Location": "Northside",
      "Collection": [
        {"ISBN": "1234", "Title": "Dune"},
        {"ISBN": "5678", "Title": "Foundation"}
      ]
    },
    {
      "BranchID": "B",
      "Location": "Southside",
      "Collection": [
        {"ISBN": "9101", "Title": "The Martian"}
      ]
    }
  ]
}
```

### Extensible Markup Language (XML)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<User UserID="U0045" Status="Active">
    <Name>Jane Doe</Name>
    <DateJoined>2023-01-15</DateJoined>
    <ContactDetails>
        <Email>jane.doe@work.com</Email>
        <Phone>555-1234</Phone>
        <EmergencyContact>
            <Name>John Doe</Name>
            <Phone>555-9876</Phone>
        </EmergencyContact>
    </ContactDetails>
</User>
```



## Unstructured Data

Data whose bytes cannot be structured. 

### Markdown (MD)

```md
## Data Formats
Different data formats require different management systems

$$
Structured Data \Leftrightarrow Relational Databases\\
$$

$$
Semi-structured Data \Leftrightarrow Document, Key-Value, Graph, ...\\
$$

$$
Unstructured Data \Leftrightarrow
Objects, Files, Blocks, Buckets, \\
$$


- Relational DBMS: MySQL, Postgres
- NoSQL DBMS: MongoDB, Apache Cassandra, JanusGraph
- Object \& File Storages: Amazon S3, Google Cloud Storage, MinIO

![Logical Architectur](./image/1_DBMSArchitecture_PSQL.drawio.png)
```

### Portable Network Graphic (PNG)

```
; Pixelpoint.png
89 50 4E 47 0D 0A 1A 0A    ; PNG Signature
00 00 00 0D                ; IHDR Chunk Length: 13 bytes
49 48 44 52                ; IHDR Chunk Type ("IHDR")
00 00 00 01                ; Image Width: 1 pixel (big-endian)
00 00 00 01                ; Image Height: 1 pixel (big-endian)
08                         ; Bit Depth: 8 (bits per channel)
06                         ; Color Type: 6 (RGBA - Truecolor with alpha)
00                         ; Compression Method: 0 (DEFLATE)
00                         ; Filter Method: 0 (Adaptive filtering)
00                         ; Interlace Method: 0 (No interlace)
6B 0D 81 C3                ; IHDR CRC
00 00 00 00                ; IEND Chunk Length: 0 bytes
49 45 4E 44                ; IEND Chunk Type ("IEND")
AE 42 60 82                ; IEND CRC
```

### Waveform Audio File Format (WAV)


```
; MajorTom.wav
52 49 46 46 ; File signature as RIFF Chunk ID
2C 1F 00 00 ; File Size, here 8044 bytes. Follows little-endian 
57 41 56 45 ; Format (The letters "WAVE")

66 6D 74 20 ; ID of subchunk 1, "fmt "
10 00 00 00 ; Size of subchunk 1, 16 bytes. Follows little-endian
01 00       ; Audio Format (1 = PCM/uncompressed)
01 00       ; Number of Channels (1 = Mono)
40 1F 00 00 ; Sample Rate (8000 Hz)
40 1F 00 00 ; Byte Rate (8000 bytes/sec)
01 00       ; Block Alignment (1 byte/sample frame)
08 00       ; Bits Per Sample (8 bits)

64 61 74 61 ; ID of subchunk 2, "data"
00 1F 00 00 ; Size of subchunk 2, 8000 bytes, the size of the raw audio data
80 80 80 80 ; First 4 bytes of the 8000. 
...
```

---
uid: server-media-comics
title: Comics
---

# Comics / Mangas

Comics and Mangas, from now on referred to as Comics, should usually be in the library root directory or in a subfolder for the individual comics. The subfolders allow for organization of metadata and images.

For best results, it is recommended to name the files similar to the following schema where the volume number and issue number are used **interchangeable**.

```txt
Series_Name #IssueNumber (of Count) (PubYear).ext
Series_Name (SeriesYear) #IssueNum (of Count) (PubYear).ext
```

- Count = Total number of issues
- PubYear = Publication year of the issue
- SeriesYear = Start year of the series
- .ext = file extension, e.g. `.cbz` or `.cbr`

Take a look at the following example:

```txt
Comics
├── Plastic Man #002 (1944).cbz
├── Attack on Titan #001 (2012).cbz
└── Comic (2008)
    ├── ComicInfo.xml
    └── Comic #001 (2008).cbr
```

Placing comics into a subfolder allows the placement of a `ComicInfo.xml` file for metadata parsing. Currently, Jellyfin does not support this for a series as a whole, but only for individual comics.

## Local Metadata for "Comic Book Archive's"

Should you're files not correspond to either `.cbz` or `.cbr` files, please refer to the [section on Books](xref:server-media-books) to see what is supported.

The following metadata formats are supported:

- ComicInfo (from ComicRack)
- ComicBookInfo (from ComicBookLover)

> [!Note]
> However, their are some limitations regarding the support of the ComicInfo format. `ComicInfo.xml` files can be parsed when they are placed in the same folder as the comic itself or when they are bundled within a `.cbz` file. `ComicInfo.xml` files bundled with any other archive format are not supported. 


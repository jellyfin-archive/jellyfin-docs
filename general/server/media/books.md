---
uid: server-media-books
title: Books
---

# Books

The most common organization scheme for books is separation by Audiobook then by Author.

```txt
Books
├── Audiobooks
│   ├── Author
│   │   ├── Book1.flac
│   │   └── Book2.flac
│   └── Book
│       ├── Chapter1.flac
│       └── Chapter2.flac
└── Books
    └── Author
        ├── Book1.epub
        ├── Book2.epub
        ├── Book
        │   ├── Book1.epub
        │   ├── cover.ext
        │   └── metadata.opf
        └── Book3.mp3
```

File extensions supported include azw, azw3, cb7, cbr, cbt, cbz, epub, mobi, and pdf.

## Local Metadata

In case the book is stored in the epub format, internal metadata can be provided. For every other format, metadata has to be provided externally in a `content.opf` or `metadata.opf` file. When multiple books have been published by the same author, it is recommended to place each book into a seperate folder. This allows to provide local metadata for every book.

Either the `content.opf` or the `metadata.opf` file can tell Jellyfin which file should be used for the books cover. Usually, this is the `cover.ext` file. The abbreviation `ext` stands for extension, e.g. `.png` or `.jpg`.

## Reader Support

Jellyfin Web supports to save your reading progress. This functionality is, however, limited. For books of the type pdf, this is limited to chapters and sub-chapters only. Books stored in the epub format save the reading progress on a per-chapter basis.

> [!Note]
> Jellyfin saves your reading progress based on a time interval. This means, Jellyfin might not save your progress immediately when you enter a new chapter.

## Primary

* folder
* poster
* cover

## Banner

* banner

## Logo

* logo

## Thumb

* thumb
* landscape

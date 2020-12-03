---
uid: server-media-movies
title: Movies
---

# Movies

Movies should usually be in the library root directory or in a subfolder for the individual films. The subfolders allow for organization of metadata and images. Adding the year at the end in parentheses will yield the best results when scraping metadata.

```txt
Movies
├── Film (1990).mp4
├── Film (1994).mp4
├── Film (2008)
│   └── Film.mkv
└── Film (2010)
    ├── Film-cd1.avi
    └── Film-cd2.avi
```

## Multiple Versions of a Movie

Multiple versions of a movie can be stored together and presented as a single title. Place each movie version in the same folder and give each version a name with the folder name as a prefix as seen below.

```txt
Movies
└── Best_Movie_Ever (2019)
    ├── Best_Movie_Ever (2019) - 1080P.mp4
    ├── Best_Movie_Ever (2019) - 720P.mp4
    └── Best_Movie_Ever (2019) - Directors Cut.mp4
```

To distinguish between versions, each filename needs to have a space, hyphen, space, and then a label. Labels are not predetermined and can be made up by the user.

> [!Note]
> The hyphen is required. Periods, commas and other characters are not supported.

Additionally, labels can be placed between brackets with the same result as seen below.

```txt
Movies
└── Best_Movie_Ever (2019)
    ├── Best_Movie_Ever (2019) - [1080P].mp4
    ├── Best_Movie_Ever (2019) - [720P].mp4
    └── Best_Movie_Ever (2019) - [Directors Cut].mp4
```

If labels are not added to the end of filenames, as shown above, each file will be treated as a unique movie and not a version of the same movie.

> [!Note]
> To group media manually, long-click or right-click media to highlight then select additional media to merge. Use the new bar that appears to 'Group Versions'.

### Order of Versions

Movie versions are presented in an alphabetically sorted list. An exception applies to resolution names, which are sorted in descending order from highest to lowest resolution. A version name qualifies as a resolution name when ending with either a `p` or an `i`.

> [!Note]
> The first movie version in the list is the one selected by default.

**Examples of sorting**
* `1080p`, `2160p`, `360p`, `480p`, `720p` → `2160p`, `1080p`, `720p`, `480p`, `360p`
* `Extended Cut`, `Cinematic Cut`, `Director's Cut` → `Cinematic Cut`, `Director's Cut`, `Extended Cut`

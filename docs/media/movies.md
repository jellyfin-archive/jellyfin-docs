## Movies

Movies should usually be in the library root directory or in a subfolder for the individual films. The subfolders allow for organization of metadata and images. Adding the year at the end in parentheses will yield the best results when scraping metadata.

```
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

Multiple versions of a movie can be stored together and presented
as a single title. Place each movie version in the same folder and give each version a name with the folder name as a prefix as seen below.

```
    Movies
    └── Best_Movie_Ever (2019)
        ├── Best_Movie_Ever (2019) - 1080P.mp4
        ├── Best_Movie_Ever (2019) - 720P.mp4
        └── Best_Movie_Ever (2019) - Directors Cut.mp4
```

To distinguish between versions, each filename needs to have a space, hyphen, space, and then a label. Labels are not predetermined and can be made up by the user.

Additionally, labels can be placed between brackets with the same result as seen below.

```
Movies
└── Best_Movie_Ever (2019)
    ├── Best_Movie_Ever (2019) - [1080P].mp4
    ├── Best_Movie_Ever (2019) - [720P].mp4
    └── Best_Movie_Ever (2019) - [Directors Cut].mp4
```
If labels are not added to the end of filenames, as shown above, each file will be treated as a unique movie and not a version of the same movie.
# Site

Public facing files.

## File listing to JSON

```@shell
#!/usr/bin/env bash

# ls -lR Web/{Galleries,Movies}/Public/ |\
ls -lR Public/Web/{Galleries,Images,Movies} |\
    jc --ls |\
    jq '.[]' |\
    sed -e 's/"flags": "drwx------"/"type": "dir"/' |\
    sed -e 's/"flags": "-rwx------"/"type": "file"/' |\
    grep -v "links" |\
    jq .
```

## Details

To make git management easier, all the current year files (that are actually getting changed)
are put into `.../Site/Details/` with symlinks from this year's Index and KeyValue values.

The **Index** files are kept in: `.../Site/Index/{MetArt,SexArt,VivThomas}/{Galleries,Movies}/ccyy.txt`

The **KeyValue** files are kept in `.../Site/KeyValue/{MetArt,SexArt,VivThomas}/{Galleries,Movies}/ccyy.txt`

The KeyValue files can be rendered to JSON or YAML with `nnma`.


## Clean (cast) details

```shell
sed -f ~/Developer/AJPippin/Other/Site/Details/clean.sed -i '' \
    ~/Developer/AJPippin/Other/Site/KeyValue/MetArt/Models/2021.kv
```

## Persistable Objects

Starting 2026-05-01, all objects that can be persisted (details, files, models) will have a unique identifier *(id)*

* default **filetype** is "details"  
* default **sequence** is 0  

#### For gallery or movie types:

    /gallery/SexArt/CCYYMMDD-dashed-title
    /movie/VivThomas/CCYYMMDD-dashed-title/jpg


#### For model types:

    /models/MetArt/dashed-lowercase-name
    /models/MetArt/dashed-lowercase-name/jpg/0


#### For example:

    /gallery/metart/20260501-presenting-erika-heiss
    /gallery/metart/20260501-presenting-erika-heiss/details   (always a key-value list)
    /gallery/metart/20260501-presenting-erika-heiss/jpg/0     (usually a clean portrait)
    /gallery/metart/20260501-presenting-erika-heiss/jpg/1     (usually a clean landscape)
    /gallery/metart/20260501-presenting-erika-heiss/zip/0     (usually high quality)
    /gallery/metart/20260501-presenting-erika-heiss/mp4/0     (usually 1k)
    /gallery/metart/20260501-presenting-erika-heiss/mp4/1     (usually 4k)
    /model/metart/erika-heiss
    /model/metart/erika-heiss/jpg/0                           (usually a clean portrait)
    /model/metart/erika-heiss/jpg/1                           (rare; usually a clean landscape)

**Important:** This doesn't necessarily imply a heirarchial storage method.  These are just _id_'s.
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

### Order:

Item detail order is not enforced.  But it is _**preferably**_:
* title:
* id: /type/site/ccyymmdd-hyphenated-title
* type: Type
* site: Site
* released: ccyy-mm-dd
* model: n:First Name; u:https://www.metart.com/model/first-name; g:f; id:/model/site/hyphenated-name
* [...model...]
* description: Full description.
* fileprefix: MetArt-20260501-presenting-erika-heiss
* url: https://www.metart.com/model/erika-heiss/gallery/20260501/PRESENTING_ERIKA_HEISS
* [...detail mappingss...]
* file: p:MetArt-20260501-presenting-erika-heiss.jpg; k:76; t:jpg; o:portrait; id:/gallery/metart/20260501-presenting-erika-heiss/jpg
* file: p:MetArt-20260501-presenting-erika-heiss.zip; k:442656; n:119; t:zip; id:/gallery/metart/20260501-presenting-erika-heiss/zip
* [...files...]
* tag: blah
* tag: blahblah
* [...tags...]
 

When generating text from a (gallery || movie) index, an item should look like:  

From:
```text

```
To:
```text
  [...]
---
title: Studious Flirt
id: /gallery/metart/20200101-studious-flirt
type: Gallery
site: MetArt
released: 2020-01-01
url: https://www.metart.com/model/angely-grace/gallery/20200101/STUDIOUS_FLIRT
model: n:Angely Grace; u:https://www.metart.com/model/angely-grace; g:f; id:/model/metart/angely-grace
photographer: billy-joe-bob
rating: ##
fileprefix: MetArt-20200101-studious-flirt
files: xxxx

description: xxxx


---
  [...]
```

When generating text from a model index, an item should look like:  

From:
```text
* model: n:First Name; u:https://www.metart.com/model/first-name; g:f; id:/model/metart/first-name
* cast: n:Second Name; u:https://www.sexart.com/model/second-name; g:m; id:/model/sexart/second-name
```
To:
```text
  [...]
---
title: First Name
id: /model/metart/first-name
type: Model
site: MetArt
url: https://www.metart.com/model/vetra
gender: Female
dateAdded: 2026-05-01
fileprefix: first-name
files: xxxx

origin: xx

details+bio: xxxx


---
title: Second Name
id: /model/sexart/second-name
type: Model
site: SexArt
url: https://www.sexart.com/model/second-name
gender: Female
dateAdded: 2026-05-01
fileprefix: second-name
files: xxxx

origin: xx

details+bio: xxxx


---
  [...]
```

Note: The gender may not be generated from the txt.
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

    /gallery/sexart/CCYYMMDD-dashed-title
    /movie/vivthomas/CCYYMMDD-dashed-title/jpg


#### For model types:

    /model/metart/dashed-lowercase-name
    /model/metart/dashed-lowercase-name/jpg/0


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
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
* file: p:MetArt-20260501-presenting-erika-heiss.zip; k:442656; t:zip; n:119; id:/gallery/metart/20260501-presenting-erika-heiss/zip
* [...files...]
* tag: blah
* tag: blahblah
* [...tags...]
 

When generating text from an index, the item (and should look like:  

From:
```text
@site MetArt
@type gallery
Studious Flirt - Angely Grace
Studious Flirt
Released: Jan 01, 2020
Featuring: Angely Grace
Photographer: Arkisi
Rating: 9.4
@site SexArt
@type Movie
We Just Click - Sasha Paige - Luna Roulette
We Just Click
Released: May 01, 2026
Featuring: Sasha Paige, Luna Roulette
Director: Andrej Lupin
Rating: 9.4
```
\
To:
```text
  [...]
  
---   ========================================================================
title: Studious Flirt
id: /gallery/metart/20200101-studious-flirt
type: Gallery
site: MetArt
released: 2020-01-01
cast: n:Angely Grace; u:https://www.metart.com/model/angely-grace; g:f; id:/model/metart/angely-grace
url: https://www.metart.com/model/angely-grace/gallery/20200101/STUDIOUS_FLIRT
photographer: billy-joe-bob
rating: 94
fileprefix: MetArt_20200101_studious-flirt
files: xxxx

description: xxxx


---
title: Angely Grace
id: /model/metart/angely-grace
type: Model
site: MetArt
file: xx; id:/model/metart/angely-grace/jpg
gender: Female
dateAdded: 2026-05-01
url: https://www.metart.com/model/angely-grace
fileprefix: Model_MetArt_angely-grace
origin: xx

details+bio: xxxx


---   ========================================================================
title: We Just Click
id: /movie/sexart/20260501-studious-flirt
type: Movie
site: SexArt
released: 2026-05-01
cast: n:Sasha Paige; u:https://www.sexart.com/model/sasha-paige; g:f; id:/model/sexart/sasha-paige
cast: n:Luna Roulette; u:https://www.sexart.com/model/luna-roulette; g:f; id:/model/sexart/luna-roulette
url: https://www.sexart.com/model/sasha-paige-and-luna-roulette/movie/20260501/WE_JUST_CLICK
director: Andrej Lupin
rating: 94
fileprefix: MetArt_20260501-studious-flirt
files: xxxx

description: xxxx


---
title: Sasha Paige
id: /model/metart/sasha-paige
type: Model
site: MetArt
file: xx; id:/model/metart/sasha-paige/jpg
gender: Female
dateAdded: 2026-05-01
url: https://www.sexart.com/model/sasha-paige
fileprefix: Model_SexArt_sasha-paige
origin: xx

details+bio: xxxx


---
cast: n:Luna Roulette; u:https://www.sexart.com/model/luna-roulette; g:f; id:/model/sexart/luna-roulette

title: Angely Grace
id: /model/metart/angely-grace
type: Model
site: MetArt
file: xx; id:/model/metart/angely-grace/jpg
gender: Female
dateAdded: 2026-05-01
url: https://www.metart.com/model/angely-grace
fileprefix: Model_MetArt_angely-grace
origin: xx

details+bio: xxxx


---   ========================================================================

  [...]
```

**_Note_**: The gender may not be correctly generated from the text block.  Default gender is Female.


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
    /gallery/metart/20260501-presenting-erika-heiss/details   (HTML text (probably key-value or YAML list))
    /gallery/metart/20260501-presenting-erika-heiss/kv        (key-value text list)
    /gallery/metart/20260501-presenting-erika-heiss/json      (JSON structure)
    /gallery/metart/20260501-presenting-erika-heiss/yaml      (YAML structure)
    /gallery/metart/20260501-presenting-erika-heiss/jpg/0     (usually a clean portrait)
    /gallery/metart/20260501-presenting-erika-heiss/jpg/1     (usually a clean landscape)
    /gallery/metart/20260501-presenting-erika-heiss/zip/0     (usually high quality)
    /gallery/metart/20260501-presenting-erika-heiss/mp4/0     (usually 1k)
    /gallery/metart/20260501-presenting-erika-heiss/mp4/1     (usually 4k)
    /model/metart/erika-heiss
    /model/metart/erika-heiss/jpg/0                           (usually a clean portrait)
    /model/metart/erika-heiss/jpg/1                           (rare; usually a clean landscape)

**Important:** This doesn't necessarily imply a heirarchial storage method.  These are just _id_'s.


## Notes

```shell
% filter='.video | { "duration": .duration, "rating": .rating, "ratings": .ratings, "title": .title, "url": .url, "publish_date": .publish_date, "pornstars": .pornstars, "segment": .segment, "tags": .tags }'
% id=6a8dfb0faec55
% curl --silent 'https://www.pornhub.com/webmasters/video_by_id?id='${id} | jq "${filter}"
```
```json
{
  "duration": "7:07",
  "rating": 78.0488,
  "ratings": 246,
  "title": "The Most Beautiful French Woman Lets Us Fuck Her In The Ass To Thank Us For Her Promotion !!!",
  "url": "https://www.pornhub.com/view_video.php?viewkey=6a8dfb0faec55",
  "publish_date": "2026-08-25 20:47:19",
  "pornstars": [],
  "segment": "straight",
  "tags": [
    {
      "tag_name": "interracial"
    },
    {
      "tag_name": "french"
    },
    {
      "tag_name": "amateur interracial"
    },
    {
      "tag_name": "french amateur"
    },
    {
      "tag_name": "interracial amateur"
    },
    {
      "tag_name": "french anal"
    },
    {
      "tag_name": "anal interracial"
    },
    {
      "tag_name": "best doggystyle"
    },
    {
      "tag_name": "big ass doggystyle"
    },
    {
      "tag_name": "doggystyle"
    },
    {
      "tag_name": "missionary"
    },
    {
      "tag_name": "hot standing sex"
    },
    {
      "tag_name": "hardcore"
    },
    {
      "tag_name": "hard rough sex"
    }
  ]
}
```



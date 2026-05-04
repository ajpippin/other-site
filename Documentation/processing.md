# Processing Images

## Sites

### MetArt

* Scrape --> KV
* Download --> local
* KV --> Database
* Push images to long-term storage

### Pornhub

* Scape --> YAML
* YAML --> Database

### Others

* X-Art


## Scrape

This step takes the site specific information form a copy to an item object in my text format ("keyvalue")

### Text

* Index Page  ("scrape index")
* Description and Tags ("scrape trs")


## Items

### Source text:

```text
The Title Is - model1 - model2
The Title Is
Released: Mmm dd, yyyy
Featuring: model1, model2
Director: CreatorName
Rating: #.#
```

### Intermediate text:

Site = site  
Type = type  

```text
title: %source.Title%
id: /%key.type%/%key.site%/%key.idKey%
type: %source.Type%
site: %source.Site%
released: %key.dateISO%
cast: n:%model[0].title u:%key.model[0].url; g:f; id:/model/%key.site%/%model[0].key.hyphenName%
cast: n:%model[1].title u:%key.model[1].url; g:f; id:/model/%key.site%/%model[1].key.hyphenName%
released: %key.dateISO%
director: %source.CreatorName%
fileprefix: %key.filePrefix%
rating: %source.Rating%
url: %key.url%

key.type: f'lower(%source.Type%)
key.site: f'lower(%source.Site%)
key.dateISO: f'parseDate(%source.Released%)
key.castNames: f'concatNames(%source.Featuring)%
key.hyphenName: f'hyphen(%key.title/ /-/%)
key.url: https://www.%key.site%.com/model/%key.castNames%/%key.type%/%key.dateISO%/f'upper(%key.hyphenName%)
key.filePrefix: %source.Site%-f'optionalDate(%key.id%)%key.hyphenName%

files: xxxx

description: xxxx


---
title: %source.model[0].Name%
id: /model/%parent.key.site%/%key.hyphenName%
type: Model
site: %parent.Site%
dateAdded: %key.todayISO%
gender: Female
url: https://www.%parent.key.site%.com/model/%key.hyphenName%
key.todayISO: f'parseDate(%now()%)
key.castNames: f'concatNames(%source.Featuring)%
key.hyphenName: f'hyphen(%key.title/ /-/%)
fileprefix: Model_%parent.Site%_%key.hyphenName%
file: xx; id:/model/%key.site%/%key.hyphenName%/jpg
origin: xx

details: xxxx


---
title: %source.model[0].Name%
id: /model/%parent.key.site%/%key.hyphenName%
type: Model
site: %parent.Site%
dateAdded: %key.todayISO%
gender: Female
url: https://www.%parent.key.site%.com/model/%key.hyphenName%
key.todayISO: f'parseDate(%now()%)
key.castNames: f'concatNames(%source.Featuring)%
key.hyphenName: f'hyphen(%key.title/ /-/%)
fileprefix: Model_%parent.Site%_%key.hyphenName%
file: xx; id:/model/%key.site%/%key.hyphenName%/jpg
origin: xx

details: xxxx


---
title: %source.model[0].Name%
id: /model/%parent.key.site%/%key.hyphenName%
type: Model
site: %parent.Site%
dateAdded: %key.todayISO%
gender: Female
url: https://www.%parent.key.site%.com/model/%key.hyphenName%
key.todayISO: f'parseDate(%now()%)
key.castNames: f'concatNames(%source.Featuring)%
key.hyphenName: f'hyphen(%key.title/ /-/%)
fileprefix: Model_%parent.Site%_%key.hyphenName%
file: xx; id:/model/%key.site%/%key.hyphenName%/jpg
origin: xx

details: xxxx


---   ============================================================================================================== ---
```

### Final text:

```yaml
- title: %source.Title%
  id: /%key.type%/%key.site%/%key.fileName%
  type: %source.type%
  site: %source.site%
  dateISO: %key.dateISO%
  models:
    - id: /model/%key.site%/%model[0].key.hyphenName%
    - id: /model/%key.site%/%model[1].key.hyphenName%
  files:
    - id: %id%/jpg/0
    - id: %id%/zip/0
  details:
      filePrefix: %key.filePrefix%
      "%key.creatorType%": %creatorName%
      url: %key.url%
      rating: %key.Rating%
      key2: value2
      key3: value3
  tags:
    - tag1
    - tag2
    - tag3
  keys:
    creatorType: f'creatorType(%key.type%)
    date8: %key.dateISO/-//%
    dateISO: f'parseDate(%source.Released%)
    fileName: %key.date8%_%key.hyphenItemName%
    filePrefix: %site%_%key.fileName%
    hyphenName: f'hyphen(%key.title/ /-/%)
    rating: f'normalized(%source.Rating%)
    site: f'lower(%site%)
    sortName: f'sortName(%key.title%)
    type: f'lower(%type%)
    url: https://www.%key.site%.com/model/%key.castNames%/%key.type%/%key.dateISO%/f'upper(%key.hyphenName%)


- title: Model Name 1
  id: /%type%/%site%/%key.hyphenName%
  type: Model
  site: %site%
  files:
    - id: /%key.type%/%key.site%/%key.hyphenName%/jpg
  details:
    addedOn: %key.todayISO%
    filePrefix: %site%_%type%_%key.hyphenName%
    key3: value3
    key4: value4
  keys:
    hyphenName: f'hyphen(%key.title/ /-/%)
    type: %parent.key.type%
    site: %parent.key.site%
    todayISO: f'parseDate(%now()%)
    filePrefix: %key.hyphenName%
- title: Model Name 2
  id: /%type%/%site%/%key.hyphenName%
  type: Model
  site: %key.site%
  files:
    - id: /%parent.key.type%/%parent.key.site%/%key.hyphenName%/jpg
  details:
    addedOn: %key.todayISO%
    filePrefix: %site%_%type%_%key.hyphenName%
    key3: value3
    key4: value4
  keys:
    hyphenName: f'hyphen(%key.title/ /-/%)
    type: %parent.key.type%
    site: %parent.key.site%
    todayISO: f'parseDate(%now()%)
    filePrefix: %key.hyphenName%

- id: %parent.file[0].id%
  type: File
  site: %parent.key.site%
  details:
    path: %parent.key.filePrefix%.%key.fileExtension%
    sizeKiB: %source.sizeKiB%
    type: %key.fileType%
    orientation: %source.orientation%
  keys:
    fileExtension: jpg
    fileType: jpg
- id: %parent.file[1].id%
  type: File
  site: %parent.key.site%
  details:
    path: %parent.key.filePrefix%.%key.fileType%
    sizeKiB: %source.sizeKiB%
    type: %key.fileType%
    images: %source.images%
  keys:
    fileExtension: zip
    fileType: zip

```

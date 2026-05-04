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

Note: `Site` and `Type` are defined externally.

```text
The Title Is - model1 - model2
The Title Is
Released: Mmm dd, yyyy
Featuring: model1, model2
Director: CreatorName
Rating: #.#
```
Which parses to:  
```go
package text

type TextSourceItem struct {
	Site      string
	Type      string
	Title     string
	Released  string
	Featuring string
	Creator   string
	Rating    string
}

var newItem = &TextSourceItem{
	Site:      `SiteName`,
	Type:      `TypeName`,
	Title:     `The Title Is`,
	Released:  `Mmm dd, yyyy`,
	Featuring: `model1, model2`,
	Creator:   `CreatorName`,
	Rating:    `#.#`,
}
```


### Intermediate text:

Keys:
```go
package text

var key = map[string]string {
	// stage 0
    "extMpg": "mp4",
    "extJpg": "jpg",
    "extZip": "zip",
	// stage 1
    "sortName": "f'sortName(%key.title%)",
    "todayISO": "f'parseDate(%now()%)",
    "castNames": "f'concatNames(%source.Featuring%)",
    "dateISO": "f'parseDate(%source.Released%)",
    "hyphenName": "f'hyphen(%key.title/ /-/%)",
    "keyJpg": "%key.extJpg%",
    "keyJpgTall": "%key.extJpg%/0",
    "keyJpgWide": "%key.extJpg%/1",
    "keyMpg1K": "%key.extMpg%/0",
    "keyMpg4K": "%key.extMpg%/1",
    "keyZip": "%key.extZip%",
    "model0.name": "%source.Featuring[0]%",
    "model1.name": "%source.Featuring[1]%",
    "rating": "f'normalized(%source.Rating%)",
    "site": "f'lower(%source.Site%)",
    "type": "f'lower(%source.Type%)",
    // stage 2
    "creatorType": "f'creatorType(%key.type%)",
    "dateCCYYMMDD": "%key.dateISO/-//%",
    "filePrefix": "%source.Site%_-f'optionalDate(%key.type%, %key.dateISO%_)%key.hyphenName%",
    "model0_hypenName": "f'hyphenate(%model0.name%)",
    "model1_hypenName": "f'hyphenate(%model1.name%)",
    "url": "https://www.%key.site%.com/model/%key.castNames%/%key.type%/%key.dateISO%/f'upper(%key.hyphenName%)",
	// stage 3
	"model0_url": "https://www.%key.site%.com/model/%model0_hypenName%",
    "model1_url": "https://www.%key.site%.com/model/%model1_hypenName%",
} 
```

```text
title: %source.Title%
id: /%key.type%/%key.site%/%key.idKey%
type: %source.Type%
site: %source.Site%
released: %key.dateISO%
cast: n:%model0.name u:model0.url; g:f; id:/model/%key.site%/%model0.hypenName%
cast: n:%model1.name u:model1.url; g:f; id:/model/%key.site%/%model1.hypenName%
released: %key.dateISO%
director: %source.CreatorName%
fileprefix: %key.filePrefix%
rating: %source.Rating%
url: %key.url%


files: xxxx

description: xxxx


---
title: %skey.model0.name%
id: /model/%key.site%/%key.model0.hypenName%
type: Model
site: %source.Site%
dateAdded: %key.todayISO%
gender: Female
url: https://www.%key.site%.com/model/%key.model0.hypenName%
fileprefix: Model_%source.Site%_%key.model0.hypenName%
file: xx; id:/model/%key.site%/%key.model0.hypenName%/jpg
origin: xx

details: xxxx


---
title: %skey.model1.name%
id: /model/%key.site%/%key.model1.hypenName%
type: Model
site: %source.Site%
dateAdded: %key.todayISO%
gender: Female
url: https://www.%key.site%.com/model/%key.model1.hypenName%
fileprefix: Model_%source.Site%_%key.model1.hypenName%
file: xx; id:/model/%key.site%/%key.model1.hypenName%/jpg
origin: xx

details: xxxx


---   ============================================================================================================== ---
```

### Final text:

**Item.yaml**:
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

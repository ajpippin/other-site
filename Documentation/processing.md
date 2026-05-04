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
	Keys      map[string]string
}

```


### Intermediate text:

Keys:
```go
var newItem = &TextSourceItem{
    Site:      `SiteName`,
    Type:      `TypeName`,
    Title:     `The Title Is`,
    Released:  `Mmm dd, yyyy`,
    Featuring: `model1, model2`,
    Creator:   `CreatorName`,
    Rating:    `#.#`,
    Keys = map[string]string {
        // stage 0
        "extMpg": "mp4",
        "extJpg": "jpg",
        "extZip": "zip",
		"mpg1KSequence": "0"
		"mpg4KSequence": "1"
        "zipSequence": "0"
		"jpgSequence": "0"
		"jpgOrientation": "portrait"
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
        "id": "/%key.type%/%key.site%/f'optionalDate(%key.type%, %key.dateISO%_)%key.hyphenName%"
        "creatorType": "f'creatorType(%key.type%)",
        "dateCCYYMMDD": "%key.dateISO/-//%",
        "filePrefix": "%source.Site%_-f'optionalDate(%key.type%, %key.dateISO%_)%key.hyphenName%",
		"file0_id": "%key.filePrefix%/%key.extZip%
        "file1_id": "%key.filePrefix%.%key.extJpg%
        "model_count": "f'count(%key.Featuring%)"
        "model0_hypenName": "f'hyphenate(%model0.name%)",
        "model1_hypenName": "f'hyphenate(%model1.name%)",
        "url": "https://www.%key.site%.com/model/%key.castNames%/%key.type%/%key.dateISO%/f'upper(%key.hyphenName%)",
        // stage 3
		"file0_name": "%key.filePrefix%.%key.extZip%
		"file1_name": "%key.filePrefix%.%key.extJpg%
        "model0_id": "/model/%key.site%/%model0_hypenName%",
		"model0_id": "/model/%key.site%/%model1_hypenName%",
		"model0_fileName": "Model_%source.site%_%model0_hypenName%",
		"model1_fileName": "Model_%source.site%_%model1_hypenName%",
        "model0_url": "https://www.%key.site%.com/model/%model0_hypenName%",
        "model1_url": "https://www.%key.site%.com/model/%model1_hypenName%",
    },
}
```

file: p:MetArt-20260504-ruby-lips.jpg; k:72; t:jpg; o:portrait; id:/gallery/metart/20260504-ruby-lips/jpg
file: p:MetArt-20260504-ruby-lips.zip; k:230048; n:101; t:zip; id:/gallery/metart/20260504-ruby-lips/zip


```text
title: %source.Title%
id: %key.id%
type: %source.Type%
site: %source.Site%
released: %key.dateISO%
cast: n:%key.model0_name u:key.model0_url; g:f; id:/model/%key.site%/%model0_hypenName%
cast: n:%key.model1_name u:key.model1_url; g:f; id:/model/%key.site%/%model1_hypenName%
released: %key.dateISO%
director: %source.CreatorName%
fileprefix: %key.filePrefix%
rating: %source.Rating%
url: %key.url%

files: xxxx

description: xxxx


---
title: %key.model0_name%
id: %key.model0_id%
type: Model
site: %source.Site%
dateAdded: %key.todayISO%
gender: Female
url: %key.model0_url%
fileprefix: %key.model0_fileName%
file: p:%key.model0_fileName%.%key.extJpg%; k:% t:%keyJpg%;  id:/model/%key.site%/%key.model0.hypenName%/jpg
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

Additional keys:
```go
var newItem = &TextSourceItem{
    Keys = map[string]string {
        "file_count": "f'count(%source.Files%)"
        "mpg1KFile_size": "f'size(%file0_name%)"
        "mpg1KFile_type": "f'type(%file0_name%)"
        "mpg1KFile_orient": "f'orientation(%file0_name%)"
        "mpg1KFile_images": "f'images(%file0_name%)"
        "mpg4KFile_size": "f'size(%file0_name%)"
        "mpg4KFile_type": "f'type(%file0_name%)"
        "mpg4KFile_orient": "f'orientation(%file0_name%)"
        "mpg4KFile_images": "f'images(%file0_name%)"
        "zipFile_size": "f'size(%file0_name%)"
        "zipFile_type": "f'type(%file0_name%)"
        "zipFile_orient": "f'orientation(%file0_name%)"
        "zipFile_images": "f'images(%file0_name%)"
        "jpgFile_size": "f'size(%file0_name%)"
        "jpgFile_type": "f'type(%file0_name%)"
        "jpgFile_orient": "f'orientation(%file0_name%)"
        "jpgFile_images": "f'images(%file0_name%)"
        "model0_fileSize": "f'size(%file0_name%)"
        "model1_fileSize": "f'size(%file0_name%)"
    },
}
```
        "zipSequence": "0"
		"jpgSequence": "0"


**Item.yaml**:
```yaml
- title: %source.Title%
  id: /%key.type%/%key.site%/%key.fileName%
  type: %source.type%
  site: %source.site%
  dateISO: %key.dateISO%
  models:
    - id: /model/%key.site%/%key.model0_hypenName%
    - id: /model/%key.site%/%key.model1_hypenName%
  files:
    - id: /%key.id%/%key.extZip%/%key.zipSequence%
    - id: /%key.id%/%key.extJpg%/%key.jpgSequence%
  details:
      filePrefix: %key.filePrefix%
      "%key.creatorType%": %source.CreatorName%
      url: %key.url%
      rating: %key.Rating%
      key2: value2
      key3: value3
  tags:
    - tag1
    - tag2
    - tag3

- title: %key.model0_name%
  id: %key.model0_id%
  type: Model
  site: %source.Site%
  files:
    - id: %key.model0_id%/%key.zipExt%/0
  details:
    addedOn: %key.todayISO%
    filePrefix: Model_%source.Site%_%key.model0_hyphenName%
    key3: value3
    key4: value4
- title: %key.model1_name%
  id: %key.model1_id%
  type: Model
  site: %source.Site%
  files:
    - id: %key.model0_id%/%key.jpgExt%/0
  details:
    addedOn: %key.todayISO%
    filePrefix: %site%_%type%_%key.hyphenName%
    key3: value3
    key4: value4


  "model0_fileName": "Model_%source.site%_%model0_hypenName%",
  "model1_fileName": "Model_%source.site%_%model1_hypenName%",

- id: /%key.id%/%key.extZip%/%key.zipSequence%
  type: File
  site: %source.Site%
  details:
    path: %key.filePrefix%.%key.extZip%
    sizeKiB: %key.zipFile_size%
    type: %key.extZip%
    images: %key.zipFile_images%
- id: /%key.id%/%key.extJpg%/%key.jpgSequence%
  type: File
  site: %parent.key.site%
  details:
    path: %key.filePrefix%.%key.extJpg%
    sizeKiB: %key.jpgFile_size%
    type: %key.jpgExt%
    orientation: %key.jpgOrientation%

```

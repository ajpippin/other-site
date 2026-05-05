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

```go
package text

type Source struct {
	Site      string
	Type      string
	Title     string
	Released  string
	Featuring string
	Creator   string
	Rating    string
}

type Intermediate interface {
	String(compact ...bool) string
	KeyValue() string
	Json(pretty ...bool) string
	Yaml() string
	
	GetTitle() string
	GetId() string
	GetType() string
	GetSite() string
	GetSourceUrl() string
	GetModels() []Model
	GetModel(any) Model
	GetFiles() []File
	GetFile(any) File
	GetFilePrefix() string
	GetDate() string
}

type Item struct {
	Intermediate

	Title       string  `yaml:"title" json:"title"`
	Id          string  `yaml:"id" json:"id"`
	Type        string  `yaml:"type" json:"type"`
	Site        string  `yaml:"site" json:"site"`
	ReleaseDate string  `yaml:"release" json:"release"`
	Models      []Model `yaml:"models" json:"models"`
	Creator     string  `yaml:"creator" json:"creator"`
	Rating      string  `yaml:"rating" json:"rating"`
	Url         string  `yaml:"url" json:"url"`
	Files       []File  `yaml:"files" json:"files"`
	filePrefix  string  // Intermediate only
}

type Model struct {
	Intermediate

	Name       string `yaml:"title" json:"title"`
	Id         string `yaml:"id" json:"id"`
	Site       string `yaml:"site" json:"site"`
	Gender     string `yaml:"gender" json:"gender"`
	Url        string `yaml:"url" json:"url"`
	AddedOn    string `yaml:"addedOn" json:"addedOn"`
	Files      []File `yaml:"files" json:"files"`
	filePrefix string // Intermediate only
}

type File struct {
	Intermediate

	Id          string `yaml:"id" json:"id"`
	Path        string `yaml:"path" json:"path"`
	Site        string `yaml:"site" json:"site"`
	SizeKiB     int64  `yaml:"sizeKiB" json:"sizeKiB"`
	FileType    string `yaml:"type" json:"type"`
	Resolution  string `yaml:"res" json:"res"`
	NumImages   int    `yaml:"images" json:"images"`
	Orientation string `yaml:"orient" json:"orient"`
	DateAdded   string `yaml:"dateAdded" json:"dateAdded"`
}


```


```text
title: {{.Title}}
id: {{.Id}}
type: {{.Type}}
site: {{.Site}}
released: {{.DateISO}}
model: {{.Model[n].AsKeyValue()}}
director: {{.CreatorName}}
fileprefix: {{.FilePrefix}}
rating: {{.Rating}}
url: {{.Url}}

files: xxxx

ddt: xxxx


---
%for each .Model {
    name: {{.Name}}
    id: {{.Id}}
    type: Model
    site: {{.Site}}
    gender: {{.Gender}}}}
    url: {{.Url}}
    dateAdded: {{.TodayISO}}
    fileprefix: {{.FilePrefix}}
    
    files: xxxx
    
    origin: xx
    
    ddt: xxxx
    
    
    ---
}

---   ============================================================================================================== ---
```


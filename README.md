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

Details
=======

To make git management easier, all the current year files (that are actually getting changed)
are put into `.../Site/Details/` with symlinks from this year's Index and KeyValue values.

The **Index** files are kept in: `.../Site/Index/{MetArt,SexArt,VivThomas}/{Galleries,Movies}/ccyy.txt`

The **KeyValue** files are kept in `.../Site/KeyValue/{MetArt,SexArt,VivThomas}/{Galleries,Movies}/ccyy.txt`

The KeyValue files can be rendered to JSON or YAML with `nnma`.

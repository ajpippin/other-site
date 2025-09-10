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
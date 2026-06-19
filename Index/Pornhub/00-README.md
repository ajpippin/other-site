# `.../Other/Site/Index/Pornhub`

## Save Dom

To save the entire DOM into a text file:

0. `c sip; mkdir -p html-dom.d`
1. Open Developer Window (Alt-Shift-I)
2. Copy `<html>` element.
3. Paste into file.

```shell
alias pp='pbpaste > html-dom.d/$(date +"%Y%m%dT%H%M%S").dom'
```

## Save links

0. Open Developer Window (Alt-Shift-I)
1. `c sip` in terminal window.
2. `ph strip --loop`
3. Copy `<body>` element into paste buffer.
4. Press `s` in terminal window.


## Insert stripped links into database

```shell
ph incoming
```


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

0. `c sip`
1. `ph strip --loop`
2. Open Developer Window (Alt-Shift-I)
3. Copy `<body>` element.
4. Press `s`


## PostgreSQL

From: ~/Developer/AJPippin/Other/Info/Movies/Links/00-README.md


### Insert into database 

```sql
INSERT INTO links (link_type, link_url) VALUES
  ( 'playlist', 'https://www.pornhub.com/playlist/10001121' ),
  ( 'playlist', 'https://www.pornhub.com/playlist/100046831' ),
  ( ... ),
  ( ... )
ON CONFLICT (link_url) DO NOTHING;
```

### Create a postgres backup/restore

```shell
dump_file=dump-$(date +'%Y%m%d').sql
pg_dump postgres://site_admin@postgres.ajpippin.us/site --format=p --file=${dump_file} &&\
    gzip --best --verbose ${dump_file}
```

* Restore from backup

```sh
gunzip --to-stdout dump-20250630.sql.gz | psql 'postgres://site_admin@db.ajpippin.us/site?sslmode=require'
```


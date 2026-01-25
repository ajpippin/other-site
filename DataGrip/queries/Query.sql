select distinct link_type from links ;
select link_type, count(id) from links group by link_type;
select link_type, link_url from links  order by link_url limit 10;
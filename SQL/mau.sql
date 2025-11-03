select count(distinct puid) as mau,
main_author_name
from bookmate.audition
join bookmate.content using(main_content_id)
join bookmate.author using(main_author_id)
where DATE_TRUNC('month', msk_business_dt_str::date)>='2024-11-01' and
DATE_TRUNC('month', msk_business_dt_str::date)< '2024-12-01'
group by main_author_name
order by mau desc
limit 3
WITH user_activity AS (
    SELECT
        a.puid,
        g.usage_geo_id_name AS city,
        COUNT(DISTINCT DATE_TRUNC('month', a.msk_business_dt_str::date)) AS active_months
    FROM bookmate.audition a
    JOIN bookmate.geo g USING (usage_geo_id)
    WHERE g.usage_geo_id_name IN ('Москва', 'Санкт-Петербург')
    GROUP BY a.puid, g.usage_geo_id_name
),
city_data AS (
    SELECT
        city,
        COUNT(DISTINCT puid) AS total_users,
        SUM(active_months) * 399 AS total_revenue
    FROM user_activity
    GROUP BY city
)
SELECT
    city,
    total_users,
    ROUND(total_revenue::numeric / total_users, 2) AS ltv
FROM city_data
ORDER BY city;

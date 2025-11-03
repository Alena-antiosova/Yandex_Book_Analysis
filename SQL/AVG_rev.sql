WITH monthly_data AS (
    SELECT
        DATE_TRUNC('month', msk_business_dt_str::date)::date AS month,  -- тип date
        COUNT(DISTINCT puid) AS mau,
        SUM(hours) AS total_hours
    FROM bookmate.audition
    WHERE msk_business_dt_str::date BETWEEN '2024-09-01' AND '2024-11-30'
    GROUP BY DATE_TRUNC('month', msk_business_dt_str::date)::date
)
SELECT
    month,
    mau,
    ROUND(total_hours::numeric, 2) AS hours,
    ROUND((mau * 399)::numeric / NULLIF(total_hours,0), 2) AS avg_hour_rev
FROM monthly_data
ORDER BY month;

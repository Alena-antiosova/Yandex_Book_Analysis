WITH cohort AS (
    SELECT DISTINCT puid
    FROM bookmate.audition
    WHERE msk_business_dt_str::date = '2024-12-02'
),
daily_activity AS (
    -- уникальные дни активности каждого пользователя с 2 декабря и позже
    SELECT DISTINCT
        a.puid,
        a.msk_business_dt_str::date AS activity_date,
        a.msk_business_dt_str::date - DATE '2024-12-02' AS day_since_install
    FROM bookmate.audition a
    JOIN cohort c USING(puid)
    WHERE a.msk_business_dt_str::date >= DATE '2024-12-02'
)
SELECT
    day_since_install,
    COUNT(DISTINCT puid) AS retained_users,
    ROUND(
        COUNT(DISTINCT puid) * 1.0 / MAX(COUNT(DISTINCT puid)) OVER (), 2
    ) AS retention_rate
FROM daily_activity
GROUP BY day_since_install
ORDER BY day_since_install;

SELECT toStartOfDay(toDateTime(time)) AS __timestamp,
       country AS country,
       count(DISTINCT user_id) AS "Уникальные пользователи"
FROM simulator_20230220.feed_actions
WHERE country != 'Russia'
GROUP BY country,
         toStartOfDay(toDateTime(time))
ORDER BY "Уникальные пользователи" DESC
LIMIT 50000;

SELECT toStartOfMonth(toDateTime(time)) AS __timestamp,
       count(DISTINCT user_id) AS "Уникальные пользователи"
FROM simulator_20230220.feed_actions
GROUP BY toStartOfMonth(toDateTime(time))
ORDER BY "Уникальные пользователи" DESC
LIMIT 50000;

-- для wau и dau поменять оператов toStartofMonth на соответствующий

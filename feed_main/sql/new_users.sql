SELECT toStartOfDay(toDateTime(start_day)) AS __timestamp,
       source AS source,
                 count(DISTINCT user_id) AS "COUNT_DISTINCT(user_id)"
FROM
  (SELECT DISTINCT ON (user_id) user_id,
                      toDate(time) AS start_day,
                      source
   FROM simulator_20230220.feed_actions
   order by start_day asc) AS virtual_table
GROUP BY source,
         toStartOfDay(toDateTime(start_day))
ORDER BY "COUNT_DISTINCT(user_id)" DESC
LIMIT 1000;

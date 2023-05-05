SELECT toStartOfDay(toDateTime("toDate(date)")) AS __timestamp,
       action AS action,
       source AS source,
                 max(act_cnt) AS "MAX(act_cnt)"
FROM
  (SELECT toDate(date),
          source,
          action,
          COUNT(user_id) as act_cnt
   FROM
     (SELECT user_id
      FROM simulator_20230220.feed_actions
      GROUP BY user_id
      HAVING MIN(toDate(time)) = today() - 30) t1
   JOIN
     (SELECT user_id,
             source,
             action,
             toDate(time) AS date
      FROM simulator_20230220.feed_actions) t2 USING user_id
   GROUP BY date, source,
                  action) AS virtual_table
GROUP BY action,
         source,
         toStartOfDay(toDateTime("toDate(date)"))
ORDER BY "MAX(act_cnt)" DESC
LIMIT 10000;

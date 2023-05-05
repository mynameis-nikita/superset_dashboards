SELECT "Week" AS "Week",
       max(sticky) AS "Sticky фактор"
FROM
  (SELECT Week,
          AVG(Daily_Users_cnt) *100.0 / Weekly_Users_cnt as sticky
   FROM
     (SELECT toStartOfDay(toDate(time)) AS Day,
             toStartOfWeek(toDate(time)) AS Week,
             count(DISTINCT user_id) AS Daily_Users_cnt
      FROM simulator_20230220.feed_actions
      GROUP BY Day,
               Week
      order by Day) Daily
   JOIN
     (SELECT toStartOfWeek(toDate(time)) AS Week,
             count(DISTINCT user_id) AS Weekly_Users_cnt
      FROM simulator_20230220.feed_actions
      GROUP BY toStartOfWeek(toDate(time))
      order by toStartOfWeek(toDate(time))) Weekly using Week
   GROUP BY Weekly_Users_cnt,
            Week) AS virtual_table
GROUP BY "Week"
ORDER BY "Sticky фактор" DESC
LIMIT 1000;

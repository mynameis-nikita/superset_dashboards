SELECT date AS date,
       "toString(start_date)" AS "toString(start_date)",
       max(active_users) AS "MAX(active_users)"
FROM
  (SELECT toInt32(datediff(day, start_date, date)) as date,
          toString(start_date),
          COUNT(user_id) as active_users
   FROM
     (SELECT user_id,
             min(toDate(time)) as start_date
      FROM simulator_20230220.feed_actions
      GROUP BY user_id
      HAVING start_date between '2023-02-01' and '2023-02-30') t1
   join
     (SELECT DISTINCT user_id,
                      toDate(time) date
      FROM simulator_20230220.feed_actions
      WHERE date <= ('2023-03-30')) t2 using user_id
   GROUP BY date, start_date) AS virtual_table
GROUP BY date, "toString(start_date)"
ORDER BY "MAX(active_users)" DESC
LIMIT 5000;

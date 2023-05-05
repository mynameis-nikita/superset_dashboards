SELECT r_day AS r_day,
start AS
start, min(per) AS "MIN(per)"
FROM
  (WITH sub as
     (SELECT start_date,
             toDate(time) time,
                          count(user_id) active_users
      FROM
        (SELECT user_id,
                min(toDate(time)) as start_date
         FROM simulator_20230220.feed_actions
         WHERE source = 'organic'
         GROUP BY user_id
         HAVING start_date >= toDate('2023-02-08')
         and start_date <= toDate('2023-02-15')) t1
      join
        (SELECT distinct user_id,
                         toDate(time) as time
         FROM simulator_20230220.feed_actions
         WHERE source = 'organic'
           and toDate(time) <= toDate('2023-02-26')) as t2 on t1.user_id = t2.user_id
      GROUP BY start_date,
               time) SELECT toInt32(datediff(day, start_date, time)) as r_day,
                            toString(start_date) as start, toString(time) as date,
                                                           active_users,
                                                           round((active_users*100.0/initial), 1) as per
   FROM sub
   join
     (SELECT start_date,
             max(active_users) as initial
      FROM sub
      GROUP BY start_date) as sub2 on sub.start_date = sub2.start_date) AS virtual_table
GROUP BY r_day,
start
LIMIT 1000;

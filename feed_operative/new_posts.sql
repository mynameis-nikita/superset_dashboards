SELECT toStartOfHour(toDateTime(time)) AS __timestamp,
       count(DISTINCT post_id) AS "Новые посты"
FROM
  (SELECT DISTINCT ON (post_id) post_id,
                      user_id,
                      action,
                      time,
                      gender,
                      age,
                      country,
                      city,
                      os,
                      source,
                      exp_group,
                      if (gender = 1,
                          'male',
                          'female') as gender_label,
                         multiIf(age < 20, '0 - 20', age >= 20
                                 and age < 30, '21-30', '30+') as age_group
   FROM simulator_20230220.feed_actions
   order by time asc) AS virtual_table
WHERE time >= toDateTime('2023-03-19 09:23:21')
  AND time < toDateTime('2023-03-26 09:23:21')
  AND os IN ('Android')
GROUP BY toStartOfHour(toDateTime(time))
ORDER BY "Новые посты" DESC
LIMIT 1000;

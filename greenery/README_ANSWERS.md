# Answer sheet
#### How many users do we have?
Answer: 130
#### On average, how many orders do we receive per hour?
Answer: 7.520833
```sql
WITH orders_per_hour AS (
    SELECT 
      DATE_TRUNC('HOUR', created_at) AS timestamp_hour,
      COUNT(*) AS cnt
    FROM stg_orders
    GROUP BY timestamp_hour
)
SELECT AVG(cnt) FROM orders_per_hour;
```

#### On average, how long does an order take from being placed to being delivered?
Answer: 93.403279 hours
```sql
SELECT AVG(TIMEDIFF('hour', created_at, delivered_at)) FROM stg_orders;
```

#### How many users have only made one purchase? Two purchases? Three+ purchases?
Answer:
* 1 -	25
* 2 -	28
* 3 -	34

```sql
with orders_per_user as (
    select stg_users.user_id as uid, count(*) as purchase_count
    from stg_users
    inner join stg_orders on stg_users.user_id = stg_orders.user_id
    group by stg_users.user_id
)
select purchase_count, count(*) as number_of_user_with_this_many_purchases
from orders_per_user
group by purchase_count
order by purchase_count asc
```

#### On average, how many unique sessions do we have per hour?
Answer: 16.327586

```sql
with sessions_per_hour as (
    select
        DATE_TRUNC('hour', created_at) as timestamp_hour,
        count(distinct(session_id)) as number_of_sessions
    from stg_events
    group by timestamp_hour
)
select AVG(number_of_sessions) from sessions_per_hour;
```

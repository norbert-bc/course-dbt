What is our user repeat rate?

answer: 0.798387

```sql
with orders_per_user as (
    select stg_users.user_id as uid, count(*) as purchase_count
    from stg_users
    inner join stg_orders on stg_users.user_id = stg_orders.user_id
    group by stg_users.user_id
)
select (
    select count(*)
    from orders_per_user
    where purchase_count >= 2
) / (
    select count(*)
    from orders_per_user
) as res;
```

What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

* High Frequency of Purchases
* Recent Purchases
* High Order Value
* Positive Reviews or Feedback
* Participation in Loyalty Programs
* Product Type


Explain the product mart models you added. Why did you organize the models in the way you did?

* I've joined together with products in order to be able to respond to some questions like: What are daily page views by product? Daily orders by product?


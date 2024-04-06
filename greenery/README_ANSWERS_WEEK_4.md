## Part 1

* Which products had their inventory change from week 3 to week 4? 

```sql
select name
from inventory_snapshot
where dbt_valid_to > date '2024-03-30';
```

**Answers**:
String of pearls
ZZ Plant
Pothos
Philodendron
Bamboo
Monstera

* Now that we have 3 weeks of snapshot data, can you use the inventory changes to determine which products had the most fluctuations in inventory? Did we have any items go out of stock in the last 3 weeks? 

```sql
with cnt_of_product_changes as (
select
    product_id,
    count(*) as changes
from inventory_snapshot
where dbt_valid_to is not null
group by 1
order by changes desc
)
select P.name, PC.changes
from cnt_of_product_changes PC
inner join stg_products P on PC.product_id = P.product_id;
```

Answer:
Pothos	2
Bamboo	2
Philodendron	2
Monstera	2
String of pearls	2
ZZ Plant	2


None that ran out of stock:
```sql
with cnt_of_product_changes as (
select
    product_id,
    count(*) as changes
from inventory_snapshot
where dbt_valid_to is not null and inventory <= 0
group by 1
order by changes desc
)
select P.name, PC.changes
from cnt_of_product_changes PC
inner join stg_products P on PC.product_id = P.product_id;
```

## Part 2


```sql
select 
    sum(add_to_cart_count) / sum(page_view_count) as page_view_to_add_to_cart_conversion,
    sum(checkout_count) / sum(add_to_cart_count) as add_to_card_to_checkout_conversion
from fact_step_conversion
```

Answer:
```
page_view_to_add_to_cart_conversion add_to_card_to_checkout_conversion
0.526991	0.366126
```

## Part 3

### Part 3A

* If your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization?
  * Enhanced Collaboration and Productivity
  * Data Quality and Reliability
  * Agility and Scalability
  * Cost-effectiveness

* If your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?
  * Implement Advanced Testing and Documentation
  * Adopt a More Collaborative Development Workflow.

* If you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?
  * Proficiency in SQL and dbt
  * Awareness of Data Testing and Documentation Practices

### Part 3B

To set up dbt for production with scheduled runs, first integrate your dbt project with version control (like GitHub or GitLab) for collaboration and change tracking. Choose an orchestration tool that fits your ecosystem, such as dbt Cloud Scheduler for simplicity, Apache Airflow for complex workflows, or Prefect for a Pythonic approach. Schedule dbt runs based on the data freshness requirements, setting different frequencies (hourly, daily, weekly) for various data transformations according to their priority and dependency order. Utilize dbt’s generated artifacts and Docs for monitoring, alerting, and data discovery, ensuring stakeholders have access to an up-to-date, transparent view of the data pipeline and its lineage. Finally, implement robust security practices for sensitive data and ensure data governance is a part of your dbt models, adjusting these processes to align with your organization’s specific data needs and workflows. This streamlined setup ensures reliable, timely, and transparent data transformations supporting organizational decision-making.





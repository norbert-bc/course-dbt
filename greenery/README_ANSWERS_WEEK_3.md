
* What is our overall conversion rate?
```sql
WITH unique_session_purchased AS (
    SELECT DISTINCT(E.session_id) AS session_id
    FROM stg_events E
    INNER JOIN stg_orders O ON E.order_id = O.order_id
    WHERE E.order_id IS NOT NULL
)
SELECT (
    SELECT COUNT(DISTINCT(session_id)) FROM unique_session_purchased
) / (
    SELECT COUNT(DISTINCT(session_id)) FROM stg_events
);
```

**Answer**:
0.624567


* What is our conversion rate by product?
```sql
WITH unique_sessions_purchased_per_product AS (
    SELECT 
        OI.product_id as product_id, 
        COUNT(DISTINCT(E.session_id)) AS cnt_sessions
    FROM stg_events E
    INNER JOIN stg_orders O ON E.order_id = O.order_id
    INNER JOIN stg_order_items OI ON OI.order_id = O.order_id
    WHERE E.order_id IS NOT NULL
    GROUP BY OI.product_id
),
sessions_purchased_per_product AS (
        SELECT E.product_id as product_id, COUNT(DISTINCT(E.session_id)) AS cnt_sessions
    FROM stg_events E
    WHERE E.product_id IS NOT NULL
    GROUP BY E.product_id
)
SELECT 
    -- SP.product_id AS product_id,
    P.name AS product_name,
    COALESCE(U.cnt_sessions / SP.cnt_sessions, 0) AS conv_rate
FROM
    sessions_purchased_per_product SP
    LEFT JOIN unique_sessions_purchased_per_product U ON SP.product_id = U.product_id
    LEFT JOIN stg_products P ON SP.product_id = P.product_id
```

**Answer**:
```csv
Orchid	0.453333
Ponytail Palm	0.400000
Pink Anthurium	0.418919
Bamboo	0.537313
Spider Plant	0.474576
Birds Nest Fern	0.423077
Pothos	0.344262
Ficus	0.426471
Dragon Tree	0.467742
Snake Plant	0.397260
Alocasia Polly	0.411765
Calathea Makoyana	0.509434
Pilea Peperomioides	0.474576
Arrow Head	0.555556
Angel Wings Begonia	0.393443
ZZ Plant	0.539683
Cactus	0.545455
Peace Lily	0.409091
Devil's Ivy	0.488889
Boston Fern	0.412698
Philodendron	0.483871
Aloe Vera	0.492308
Fiddle Leaf Fig	0.500000
Jade Plant	0.478261
Majesty Palm	0.492537
String of pearls	0.609375
Money Tree	0.464286
Bird of Paradise	0.450000
Rubber Plant	0.518519
Monstera	0.510204
```
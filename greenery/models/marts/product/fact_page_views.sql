{{
  config(
    materialized='table'
  )
}}

SELECT 
    e.event_id as event_id,
    e.session_id as session_id,
    e.user_id as user_id,
    e.page_url as page_url,
    e.created_at as created_at,
    e.product_id as product_id,
    p.name as product_name,
    p.price as product_price
FROM {{ ref('stg_events') }} e
  INNER JOIN {{ ref('stg_products') }} p
WHERE event_type = 'page_view'
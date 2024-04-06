{{
  config(
    materialized='table'
  )
}}

SELECT 
    e.session_id as session_id,
    e.user_id as user_id,
    COUNT(*) as add_to_cart_count
FROM {{ ref('stg_events') }} e
WHERE event_type = 'add_to_cart'
GROUP BY 1,2
{{
  config(
    materialized='table'
  )
}}

SELECT 
    e.session_id as session_id,
    e.user_id as user_id,
    COUNT(*) AS checkout_count
FROM {{ ref('stg_events') }} e
WHERE event_type = 'checkout'
GROUP BY 1,2
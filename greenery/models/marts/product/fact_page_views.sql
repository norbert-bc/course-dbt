{{
  config(
    materialized='table'
  )
}}

SELECT 
    e.session_id as session_id,
    e.user_id as user_id,
    COUNT(*) as page_view_count
FROM {{ ref('stg_events') }} e
WHERE event_type = 'page_view'
GROUP BY 1,2
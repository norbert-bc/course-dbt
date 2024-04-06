{{
  config(
    materialized='table'
  )
}}

SELECT 
  PV.session_id as session_id,
  PV.user_id as user_id,
  COALESCE(PV.page_view_count, 0) as page_view_count,
  COALESCE(ATC.add_to_cart_count, 0) as add_to_cart_count,
  COALESCE(C.checkout_count, 0) as checkout_count
FROM {{ ref('fact_page_views') }} PV
  LEFT JOIN {{ ref('fact_add_to_cart') }} ATC ON PV.session_id = ATC.session_id
  LEFT JOIN {{ ref('fact_checkout') }} C ON PV.session_id = C.session_id


SELECT 
    sum(add_to_cart_count) / sum(page_view_count) AS page_view_to_add_to_cart_conversion,
    sum(checkout_count) / sum(add_to_cart_count) AS add_to_card_to_checkout_conversion
FROM {{ ref('funnel_step_counts') }}

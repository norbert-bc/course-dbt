

SELECT
  *
FROM {{ ref("stg_orders") }}
WHERE delivered_at IS NOT NULL AND delivered_at < created_at
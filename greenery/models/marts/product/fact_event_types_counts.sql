{{
  config(
    materialized='table'
  )
}}

SELECT
  {{ expand_event_types('stg_events', 'event_type') }}
  E.session_id
FROM
  {{ ref('stg_events') }} E
GROUP BY E.session_id
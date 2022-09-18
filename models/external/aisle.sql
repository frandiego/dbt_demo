{{
  config(
    materialized='table', 
    dataset='silver',
    name='aisle', 
    unique_key="id"
  )
}}

SELECT
    t.*,
    t._file_name AS file_name,
    CURRENT_TIMESTAMP() AS load_time
FROM {{ source('instacart_bronze', 'aisle') }} AS t

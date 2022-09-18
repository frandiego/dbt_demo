{{
  config(
    materialized='table', 
    dataset='silver',
    name='product', 
    unique_key="id"
  )
}}

SELECT
    t.*,
    t._file_name AS file_name,
    CURRENT_TIMESTAMP() AS load_time
FROM {{ source('instacart_bronze', 'product') }} AS t

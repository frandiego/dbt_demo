{{
  config(
    materialized='table', 
    dataset='silver',
    name='product', 
    unique_key="id", 
    tags=["silver"]
  )
}}

SELECT
    t.*,
    t._file_name AS file_name,
    CURRENT_TIMESTAMP() AS load_time
FROM {{ source('bronze', 'product') }} AS t

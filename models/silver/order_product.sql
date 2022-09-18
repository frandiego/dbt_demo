{{
  config(
    materialized='table', 
    dataset='silver',
    name='order_product', 
    unique_key=['product_id', 'order_id']
  )
}}

SELECT
    t.*,
    t._file_name AS file_name,
    CURRENT_TIMESTAMP() AS load_time
FROM {{ source('instacart_bronze', 'order_product') }} AS t

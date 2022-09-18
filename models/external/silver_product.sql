{{
  config(
    materialized ='table',
    name='silver_product'
  )
}}

  SELECT 
        t.*, 
        CURRENT_TIMESTAMP()  AS load_time, 
        _FILE_NAME AS file_name
    FROM {{ source('instacart', 'bronze_product') }}  t
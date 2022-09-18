{{
  config(
    materialized ='table', 
    name='silver_aisle'
  )
}}

  SELECT 
        t.*, 
        CURRENT_TIMESTAMP()  AS load_time, 
        _FILE_NAME AS file_name
    FROM {{ source('instacart', 'bronze_aisle') }}  t
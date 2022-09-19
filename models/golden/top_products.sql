{{
  config(
    materialized='table', 
    dataset='golden',
    name='top_products', 
    unique_key="product_id", 
    tags=["golden"]
  )
}}

WITH AUX AS (
    SELECT 
          l.product_id, 
          r.aisle_id, 
          r.department_id, 
          r.name as product_name, 
          count(*) as sales, 
      FROM {{ ref('order_product') }} l
      LEFT JOIN {{ ref('product') }} r
      ON l.product_id = r.id
    GROUP BY l.product_id, r.aisle_id, r.department_id, r.name
)

SELECT 
      product_id, 
      aisle_id, 
      department_id, 
      product_name, 
      sales,
      RANK() OVER (ORDER BY sales desc) AS rank
FROM AUX
ORDER BY sales DESC
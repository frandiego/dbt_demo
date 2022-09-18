{{
  config(
    materialized='table', 
    dataset='golden',
    name='top_aisles', 
    unique_key="aisle_id"
  )
}}

WITH AUX AS (
    SELECT 
          l.aisle_id, 
          l.department_id, 
          r.name as aisle_name, 
          sum(l.sales) as sales, 
      FROM {{ ref('top_products') }} l
      LEFT JOIN {{ ref('aisle') }}  r
      ON l.aisle_id = r.id
      GROUP BY l.aisle_id , l.department_id,  r.name
)
  SELECT 
      AUX.* , 
      RANK() OVER (ORDER BY AUX.sales desc) AS rank
  FROM AUX
  ORDER BY sales DESC



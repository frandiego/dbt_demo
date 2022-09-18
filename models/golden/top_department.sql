{{
  config(
    materialized='table', 
    dataset='golden',
    name='top_departments', 
    unique_key="department_id"
  )
}}

WITH AUX AS (
    SELECT  
          l.department_id, 
          r.name as aisle_name, 
          sum(l.sales) as sales, 
      FROM {{ ref('top_aisles') }} l
      LEFT JOIN {{ ref('department') }}  r
      ON l.department_id = r.id
      GROUP BY l.department_id ,  r.name
)
  SELECT 
      AUX.* , 
      RANK() OVER (ORDER BY AUX.sales desc) AS rank
  FROM AUX
  ORDER BY sales DESC



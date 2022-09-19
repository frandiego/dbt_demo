{{
  config(
    materialized='table', 
    dataset='silver',
    name='processed_files', 
    tags=["silver"]
  )
}}


{{processed_files()}}
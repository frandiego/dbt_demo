{{
  config(
    materialized='table', 
    dataset='silver',
    name='processed_files'
  )
}}


{{processed_files()}}
{% macro tables_created() %}

    SELECT 
        DISTINCT 
        table_name
    FROM 
        {{ this.schema }}.INFORMATION_SCHEMA.TABLES 

    WHERE 
        table_catalog = '{{ this.database }}'
    AND 
        table_schema = '{{ this.schema }}'
    AND 
        table_name != '{{ this.table }}'

{% endmacro %}; 

{% macro processed_files_table(table_name) %}

    select 
        distinct 
       '{{ this.schema }}' as dataset, 
       '{{ table_name }}' as table_name, 
       file_name, 
       count(*) as row_count

    from 
        {{ this.schema }}.{{ table_name }}

    group by dataset, table_name, file_name
          
{% endmacro %}; 


{% macro processed_files() %}

{% set results = run_query(tables_created()) %}
{% if execute %}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{% for table_name in results_list %}
    {{processed_files_table(table_name )}}
    {% if not loop.last %} 
        UNION ALL
    {% endif %}
{% endfor %}

{% endmacro %}; 

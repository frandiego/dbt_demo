DBT_PROFILES_DIR:=$(PWD)

install:
	pip install dbt-core==1.2.0
	pip install dbt-bigquery==1.2.0
	pip install markupsafe==2.0.1


bronze:
	dbt run-operation --profiles-dir=$(DBT_PROFILES_DIR) stage_external_sources


silver: 
	dbt run --profiles-dir=$(DBT_PROFILES_DIR) --select silver


golden: 
	dbt run --profiles-dir=$(DBT_PROFILES_DIR) --select golden


docs-generate:
	dbt docs generate --profiles-dir=$(DBT_PROFILES_DIR)


docs:  docs-generate
	dbt docs serve --profiles-dir=$(DBT_PROFILES_DIR)
DBT_PROFILES_DIR:=$(PWD)


install:
	pip install dbt-core==1.2.0
	pip install dbt-bigquery==1.2.0
	pip install markupsafe==2.0.1


external:
	dbt run-operation --profiles-dir=$(DBT_PROFILES_DIR) stage_external_sources


run: external
	dbt run --profiles-dir=$(DBT_PROFILES_DIR)


install:
	pip install dbt-core==1.2.0
	pip install dbt-bigquery==1.2.0
	pip install markupsafe==2.0.1

deps:
	dbt deps --profiles-dir=$(PWD)

bronze:
	dbt run-operation --profiles-dir=$(PWD) stage_external_sources --vars "ext_full_refresh: true"


silver: 
	dbt run --profiles-dir=$(PWD) --select silver


golden: 
	dbt run --profiles-dir=$(PWD) --select golden


docs-generate:
	dbt docs generate --profiles-dir=$(PWD)


docs:  docs-generate
	dbt docs serve --profiles-dir=$(PWD)
SERVICE_ACCOUNT_FILE := service_account.json
PROJECT_ID := elegant-tendril-362907
BRONZE_DATASET := instacart_bronze




install:
	pip install dbt-core==1.2.0
	pip install dbt-bigquery==1.2.0
	pip install markupsafe==2.0.1

activate:
	gcloud auth activate-service-account --key-file=$(SERVICE_ACCOUNT_FILE)

set: activate
	gcloud config set project $(PROJECT_ID)

create_bronze_dataset:
	bq show $(BRONZE_DATASET) || bq mk $(BRONZE_DATASET)

deps:
	dbt deps --profiles-dir=$(PWD)

bronze: 
	dbt run-operation --profiles-dir=$(PWD) stage_external_sources


silver: 
	dbt run --profiles-dir=$(PWD) --select silver


golden: 
	dbt run --profiles-dir=$(PWD) --select golden


docs-generate:
	dbt docs generate --profiles-dir=$(PWD)


docs:  docs-generate
	dbt docs serve --profiles-dir=$(PWD)


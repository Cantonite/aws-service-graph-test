fmt:
	terraform fmt -recursive

validate: fmt
	terraform validate

apply:
	terraform apply tfplan

plan: fmt validate
	terraform plan -out tfplan

URL = $(shell terraform output invoke_url)
test:
	curl $(URL)
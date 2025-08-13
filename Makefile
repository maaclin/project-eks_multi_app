

build:
	docker build -t maaclin99/portfolio .

push:
	docker push maaclin99/portfolio

init:
	terraform init 

validate: 
	terraform fmt -recursive
	terraform validate

plan:
	terraform validate
	terraform plan

lint:
	tflint --init 
	
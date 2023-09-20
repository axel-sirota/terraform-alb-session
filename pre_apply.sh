#!/usr/bin/env bash

terraform init
terraform fmt -recursive
terraform validate
terraform plan -out test.tfplan

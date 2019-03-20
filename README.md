# terraform-talk

This code is part of a demo used in a Terraform talk.

## Overview

The configuration in this repository was run using `Terraform v0.11.13`.

The configuration in this repository will create the following:

* An EC2 instance in us-east-1
* A security group for the EC2 instance
* An AWS Launch Configuration
* An Auto Scaling group
* An ELB
* A security group for the ELB

## Usage

Initialize the Terraform:

```
terraform init
```

View the changes:

```
terraform plan
```

Launch the resources:

```
terraform apply
```

## Contributors

* [Alex Podobnik](https://github.com/alexandarp)

# terraform-talk

This code is part of a demo used in a Terraform talk.

## Overview

The configuration in this repository was run using `Terraform v0.11.13`.

The configuration in this repository will create the following:

* EC2 instance in us-east-1
* Security group for the EC2 instance
* AWS Launch Configuration
* Auto Scaling group
* ELB with the existing instance attached
* Security group for the ELB

The state is stored in an S3 bucket.

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

Show resource details:

```
terraform show
```

## Questions?

```
contact@scalarsoftware.com
```

## Contributors

* [Alex Podobnik](https://github.com/alexandarp)

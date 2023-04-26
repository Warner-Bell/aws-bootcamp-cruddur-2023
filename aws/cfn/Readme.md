## Architecture Guide

Before running templates, create s3 bucket for Cloudformation artifacts. 

aws s3 mk s3://cldfrmn-artifacts
export CFN_BUCKET="cldfrmn-artifacts"
gp env CFN_BUCKET="cldfrmn-artifacts"

>bucket names need to be unique so change code example
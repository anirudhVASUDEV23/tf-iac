terraform{
    required_providers {
      aws={
        source = "hashicorp/aws"
        version = "6.38.0" 
      }
    }

    backend "s3"{
      bucket="anirudh-s3-remote-bucket"
      key="terraform.tfstate"
      region="us-east-2"
      dynamodb_table = "anirudh-dynamodb-remote-table"
    }
}
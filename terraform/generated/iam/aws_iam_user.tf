resource "aws_iam_user" "airbyte_hackathon" {
  name = "airbyte-hackathon"
  path = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_user" "dev_smtp_user" {
  name = "dev-smtp-user"
  path = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_user" "posthog_app" {
  name = "posthog-app"
  path = "/system/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_user" "s3disk" {
  name = "s3disk"
  path = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_user" "xvello_export_test" {
  name = "xvello-export-test"
  path = "/"
  tags = {
    AKIASPAP2IQFSVX5GGNP = "xvello-export-test"

    owner = "xvello"

  }
}


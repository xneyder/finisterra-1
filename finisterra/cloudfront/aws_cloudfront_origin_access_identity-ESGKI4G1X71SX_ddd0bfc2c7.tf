module "aws_cloudfront_origin_access_identity-ESGKI4G1X71SX_ddd0bfc2c7" {
  source  = "github.com/finisterra-io/terraform-aws-modules.git//cloudfront/modules/origin_access_identity?ref=main"
  comment = "CloudFront Identity to access private s3 bucket with webapp static assets"
}

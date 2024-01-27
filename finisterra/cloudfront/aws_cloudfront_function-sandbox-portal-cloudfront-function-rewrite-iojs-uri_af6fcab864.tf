locals {
  name_af6fcab864 = "sandbox-portal-cloudfront-function-rewrite-iojs-uri"
}

module "aws_cloudfront_function-sandbox-portal-cloudfront-function-rewrite-iojs-uri_af6fcab864" {
  source  = "github.com/finisterra-io/terraform-aws-modules.git//cloudfront/modules/function?ref=main"
  name    = local.name_af6fcab864
  runtime = "cloudfront-js-1.0"
  code    = <<EOF
function handler(event) {
	var request = event.request;
	request.uri = request.uri.substring("/iojs".length);
	return request;
}

EOF

}

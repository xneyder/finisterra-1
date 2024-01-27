locals {
  namespace_name_f75fbffd28 = "sandbox.coastpay.internal"
}

module "aws_service_discovery_private_dns_namespace-sandbox_coastpay_internal_f75fbffd28" {
  source                       = "github.com/finisterra-io/terraform-aws-modules.git//cloudmap?ref=main"
  create_private_dns_namespace = true
  namespace_name               = local.namespace_name_f75fbffd28
  vpc_name                     = "sandbox"
  tags = {
    "Environment" : "sandbox",
    "Terraform" : "true"
  }
  service_names = {
    "hazelcast" : {
      "name" : "hazelcast",
      "description" : "",
      "dns_records" : [
        {
          "ttl" : 10,
          "type" : "A"
        }
      ],
      "routing_policy" : "MULTIVALUE",
      "health_check_config" : [],
      "health_check_custom_config" : [
        {
          "failure_threshold" : 1
        }
      ],
      "tags" : {
        "Environment" : "sandbox",
        "Terraform" : "true"
      }
    },
    "hazelcast-q11n" : {
      "name" : "hazelcast-q11n",
      "description" : "",
      "dns_records" : [
        {
          "ttl" : 10,
          "type" : "A"
        }
      ],
      "routing_policy" : "MULTIVALUE",
      "health_check_config" : [],
      "health_check_custom_config" : [
        {
          "failure_threshold" : 1
        }
      ],
      "tags" : {
        "Environment" : "sandbox",
        "Terraform" : "true"
      }
    },
    "client-portal-bff" : {
      "name" : "client-portal-bff",
      "description" : "",
      "dns_records" : [
        {
          "ttl" : 10,
          "type" : "A"
        },
        {
          "ttl" : 10,
          "type" : "SRV"
        }
      ],
      "routing_policy" : "MULTIVALUE",
      "health_check_config" : [],
      "health_check_custom_config" : [],
      "tags" : {
        "Environment" : "sandbox",
        "Name" : "client-portal-bff",
        "Terraform" : "true"
      }
    },
    "auth-lock-hazelcast" : {
      "name" : "auth-lock-hazelcast",
      "description" : "",
      "dns_records" : [
        {
          "ttl" : 10,
          "type" : "A"
        },
        {
          "ttl" : 10,
          "type" : "SRV"
        }
      ],
      "routing_policy" : "MULTIVALUE",
      "health_check_config" : [],
      "health_check_custom_config" : [],
      "tags" : {
        "Environment" : "sandbox",
        "Name" : "auth-lock-hazelcast",
        "Terraform" : "true"
      }
    },
    "hazelcast-auth" : {
      "name" : "hazelcast-auth",
      "description" : "",
      "dns_records" : [
        {
          "ttl" : 10,
          "type" : "A"
        }
      ],
      "routing_policy" : "MULTIVALUE",
      "health_check_config" : [],
      "health_check_custom_config" : [
        {
          "failure_threshold" : 1
        }
      ],
      "tags" : {
        "Environment" : "sandbox",
        "Terraform" : "true"
      }
    }
  }
}

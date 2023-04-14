resource "aws_elasticache_user" "default" {
  access_string = "on ~* +@all"
  engine        = "REDIS"
  user_id       = "default"
  user_name     = "default"
}


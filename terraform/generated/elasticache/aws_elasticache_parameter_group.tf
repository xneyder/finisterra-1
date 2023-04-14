resource "aws_elasticache_parameter_group" "creat_sprin_jo0gqwx3495c" {
  description = "Based on the default Redis 5 configuration, but with support for Spring Session"
  family      = "redis5.0"
  name        = "creat-sprin-jo0gqwx3495c"
  parameter {
    name  = "notify-keyspace-events"
    value = "Egx"
  }
}

resource "aws_elasticache_parameter_group" "default_memcached1_4" {
  description = "Default parameter group for memcached1.4"
  family      = "memcached1.4"
  name        = "default.memcached1.4"
}

resource "aws_elasticache_parameter_group" "default_memcached1_5" {
  description = "Default parameter group for memcached1.5"
  family      = "memcached1.5"
  name        = "default.memcached1.5"
}

resource "aws_elasticache_parameter_group" "default_memcached1_6" {
  description = "Default parameter group for memcached1.6"
  family      = "memcached1.6"
  name        = "default.memcached1.6"
}

resource "aws_elasticache_parameter_group" "default_redis2_6" {
  description = "Default parameter group for redis2.6"
  family      = "redis2.6"
  name        = "default.redis2.6"
}

resource "aws_elasticache_parameter_group" "default_redis2_8" {
  description = "Default parameter group for redis2.8"
  family      = "redis2.8"
  name        = "default.redis2.8"
}

resource "aws_elasticache_parameter_group" "default_redis3_2" {
  description = "Default parameter group for redis3.2"
  family      = "redis3.2"
  name        = "default.redis3.2"
}

resource "aws_elasticache_parameter_group" "default_redis3_2_cluster_on" {
  description = "Customized default parameter group for redis3.2 with cluster mode on"
  family      = "redis3.2"
  name        = "default.redis3.2.cluster.on"
}

resource "aws_elasticache_parameter_group" "default_redis4_0" {
  description = "Default parameter group for redis4.0"
  family      = "redis4.0"
  name        = "default.redis4.0"
}

resource "aws_elasticache_parameter_group" "default_redis4_0_cluster_on" {
  description = "Customized default parameter group for redis4.0 with cluster mode on"
  family      = "redis4.0"
  name        = "default.redis4.0.cluster.on"
}

resource "aws_elasticache_parameter_group" "default_redis5_0" {
  description = "Default parameter group for redis5.0"
  family      = "redis5.0"
  name        = "default.redis5.0"
}

resource "aws_elasticache_parameter_group" "default_redis5_0_cluster_on" {
  description = "Customized default parameter group for redis5.0 with cluster mode on"
  family      = "redis5.0"
  name        = "default.redis5.0.cluster.on"
}

resource "aws_elasticache_parameter_group" "default_redis6_x" {
  description = "Default parameter group for redis6.x"
  family      = "redis6.x"
  name        = "default.redis6.x"
}

resource "aws_elasticache_parameter_group" "default_redis6_x_cluster_on" {
  description = "Customized default parameter group for redis6.x with cluster mode on"
  family      = "redis6.x"
  name        = "default.redis6.x.cluster.on"
}

resource "aws_elasticache_parameter_group" "default_redis7" {
  description = "Default parameter group for redis7"
  family      = "redis7"
  name        = "default.redis7"
}

resource "aws_elasticache_parameter_group" "default_redis7_cluster_on" {
  description = "Customized default parameter group for redis7 with cluster mode on"
  family      = "redis7"
  name        = "default.redis7.cluster.on"
}


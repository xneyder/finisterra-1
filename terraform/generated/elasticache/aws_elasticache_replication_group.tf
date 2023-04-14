resource "aws_elasticache_replication_group" "core_redis3" {
  automatic_failover_enabled = true
  cluster_mode {
  }
  description              = "simple redis 3 store for core services"
  engine                   = "redis"
  multi_az_enabled         = true
  port                     = 6379
  replication_group_id     = "core-redis3"
  snapshot_retention_limit = 7
}

resource "aws_elasticache_replication_group" "gateway_redis" {
  automatic_failover_enabled = false
  cluster_mode {
  }
  description              = " "
  engine                   = "redis"
  multi_az_enabled         = false
  port                     = 6379
  replication_group_id     = "gateway-redis"
  snapshot_retention_limit = 0
}

resource "aws_elasticache_replication_group" "general_redis_02" {
  automatic_failover_enabled = true
  cluster_mode {
  }
  description              = "General purpose Redis cluster. Can be shared across services."
  engine                   = "redis"
  multi_az_enabled         = false
  port                     = 6379
  replication_group_id     = "general-redis-02"
  snapshot_retention_limit = 7
  tags = {
    DeploymentEnvironment = "production"

    Name = "general-redis-02"

  }
}


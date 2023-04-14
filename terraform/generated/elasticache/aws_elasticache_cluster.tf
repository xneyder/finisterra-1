resource "aws_elasticache_cluster" "core_redis3_001" {
  auto_minor_version_upgrade = "true"
  cluster_id                 = "core-redis3-001"
  engine                     = "redis"
  snapshot_retention_limit   = 0
}

resource "aws_elasticache_cluster" "core_redis3_002" {
  auto_minor_version_upgrade = "true"
  cluster_id                 = "core-redis3-002"
  engine                     = "redis"
  snapshot_retention_limit   = 7
}

resource "aws_elasticache_cluster" "core_redis3_003" {
  auto_minor_version_upgrade = "true"
  cluster_id                 = "core-redis3-003"
  engine                     = "redis"
  snapshot_retention_limit   = 0
}

resource "aws_elasticache_cluster" "gateway_redis_001" {
  auto_minor_version_upgrade = "true"
  cluster_id                 = "gateway-redis-001"
  engine                     = "redis"
  snapshot_retention_limit   = 0
}

resource "aws_elasticache_cluster" "general_redis_02_001" {
  auto_minor_version_upgrade = "true"
  cluster_id                 = "general-redis-02-001"
  engine                     = "redis"
  snapshot_retention_limit   = 0
  tags = {
    DeploymentEnvironment = "production"

    Name = "general-redis-02"

  }
}

resource "aws_elasticache_cluster" "general_redis_02_002" {
  auto_minor_version_upgrade = "true"
  cluster_id                 = "general-redis-02-002"
  engine                     = "redis"
  snapshot_retention_limit   = 7
  tags = {
    DeploymentEnvironment = "production"

    Name = "general-redis-02"

  }
}


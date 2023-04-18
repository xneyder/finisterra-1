resource "aws_guardduty_detector" "dac0589c305f591f0988ac6e8f2e0872" {
  datasources {
    kubernetes {
      audit_logs {
        enable = false
      }
    }
    s3_logs {
      enable = true
    }
  }
  enable = true
}


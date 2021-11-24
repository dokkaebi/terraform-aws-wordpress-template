/**
 * # wp-db
 *
 * This module is used for creating a RDS database server for usage with Wordpress.
 *
 */

locals {
  name_prefix = "wp-${var.environment}"
}


/**
 * # wp-host
 *
 * This module is used for creating a EC2-instance running Wordpress.
 *
 */

locals {
  name_prefix = "wp-${var.environment}"
}


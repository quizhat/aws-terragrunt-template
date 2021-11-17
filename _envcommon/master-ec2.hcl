# ---------------------------------------------------------------------------------------------------------------------
# COMMON TERRAGRUNT CONFIGURATION
# This is the common component configuration for replaceme. The common variables for each environment to
# deploy replaceme are defined here. This configuration will be merged into the environment configuration
# via an include block.
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# Locals are named constants that are reusable within the configuration.
# ---------------------------------------------------------------------------------------------------------------------
locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  env = local.environment_vars.locals.environment
  cidr_block = local.environment_vars.locals.cidr_block
  # Expose the base source URL so different versions of the module can be deployed in different environments.
  base_source_url = "git::https://github.com/cloudposse/terraform-aws-dynamic-subnets//"
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module. This defines the parameters that are common across all
# environments.
# ---------------------------------------------------------------------------------------------------------------------
inputs = {
    namespace = "rb"
    name = "k8s"
    attributes = ["master"]
    environment = local.env
    ami =
    instance_type="m5.medium"
}

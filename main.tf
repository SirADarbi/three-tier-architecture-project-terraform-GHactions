module "networking" {
  source       = "./modules/networking"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  az_count     = var.az_count
}

module "security" {
  source       = "./modules/security"
  project_name = var.project_name
  vpc_id       = module.networking.vpc_id
}

module "web" {
  source            = "./modules/web"
  project_name      = var.project_name
  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
  web_alb_sg_id     = module.security.web_alb_sg_id
  web_ec2_sg_id     = module.security.web_ec2_sg_id
  instance_type     = var.instance_type
  min_size          = var.min_size
  max_size          = var.max_size
  desired_capacity  = var.desired_capacity
}

module "app" {
  source             = "./modules/app"
  project_name       = var.project_name
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  app_alb_sg_id      = module.security.app_alb_sg_id
  app_ec2_sg_id      = module.security.app_ec2_sg_id
  instance_type      = var.instance_type
  min_size           = var.min_size
  max_size           = var.max_size
  desired_capacity   = var.desired_capacity
}

module "data" {
  source              = "./modules/data"
  project_name        = var.project_name
  isolated_subnet_ids = module.networking.isolated_subnet_ids
  db_sg_id            = module.security.db_sg_id
  db_username         = var.db_username
  db_password         = var.db_password
  db_name             = var.db_name
  instance_class      = var.instance_class
}

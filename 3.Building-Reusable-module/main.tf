module "ec2_intance" {
  source = "./module/ec2"
  instance_type = "t3.micro"
  image_os = "ubuntu"
  tagging = {
    "name" = "ec2-linux-intance"
    "BusinessUnimt" = "infosec"
  }
}

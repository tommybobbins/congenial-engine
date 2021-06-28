data "template_file" "init" {
  template = file("userdata.sh")
  vars = {
    project_name = var.project_name,
    bucket_name  = var.bucket_name,
    host_name    = var.host_name,
  }
}


variable "project_name" {
  description = "Project Name"
  default     = "homer"
}

variable "host_name" {
  description = "Host Name"
  default     = "homer"
}

variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "aws_az" {
  description = "AWS Zone"
  type        = string
  default     = "us-east-1a"
}

variable "bucket_name" {
  description = "Pre-existing bucket containing site content (see userdata.sh)."
  type        = string
}


variable "rules" {
  type = list(object({
    port        = number
    proto       = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      port        = 80
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 443
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 2020
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]


}

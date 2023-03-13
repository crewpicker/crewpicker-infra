variable "name" {
  type = string
}

variable "release" {
  type = string
}

variable "replicas" {
  type = string
}

variable "image" {
  type = object({
    repo = string
    tag  = string
  })
}

variable "containerPort" {
  type = string
}

variable "hostname" {
  type = string
}

variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "vpc_name" {
  type    = string
  default = "hello-vpc"
}

variable "subnet_cidr" {
  type    = string
  default = "10.10.0.0/24"
}

variable "pods_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "services_cidr" {
  type    = string
  default = "10.30.0.0/20"
}

variable "cluster_name" {
  type    = string
  default = "hello-gke"
}

variable "cluster_release" {
  type    = string
  default = "1.29"
}

variable "node_count" {
  type    = number
  default = 2
}

variable "machine_type" {
  type    = string
  default = "e2-standard-2"
}

variable "repo_location" {
  type    = string
  default = "us-central1"
}

variable "repo_name" {
  type    = string
  default = "hello-repo"
}

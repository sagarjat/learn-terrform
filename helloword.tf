provider "aws" {
    region     = "us-east-2"
    profile = "Sagar1"
}

// variable in terraform

variable "userName" {
    type = string
    default = " this is first variable"
}

variable "multiLineString" {
    type = string
    default = <<EOT
    this is first line 
    this is second line
    this is 3rd one.
    last 
    EOT
}


output "nameOut" {
    value = "${var.userName}"
}

output "multiLine" {
    value = "${var.multiLineString}"
}

// map type variable which always present in key pairs

variable  "mapVariable" {
    type = map 
    default = {
        "useast" = "ami1"
        "uswast" = "ami2"
    }
}

output "mapOutput" {
    value = "${var.mapVariable}"
}

// array or list example in terraform

variable "arrayList" {
    type = list
    default = ["SG1","SG2","SG3"]
}

output "listOutput" {
    value = "${var.arrayList[0]}"
}

//boolean type variable in aws
variable "boolVariable" {
    default = true
}

output "output" {
    value = "${var.boolVariable}"
}



// check input and output value 
variable "userNameEnter" {
    type = string
}

output "youHaveEntered" {
    value = "${var.userNameEnter}"
}

variable "userNameEnter1" {
    type = string
}

output "youHaveEntered" {
    sensitive = true
    value = "${var.userNameEnter1}"
}
variable "ec2_instance_type"{
    default="t2.micro"
    type=string
}


variable "ec2_default_root_storage_size" {
    default=9
    type=number
}

variable "ec2_ami_id" {
    default="ami-07062e2a343acc423"
    type=string 
}

variable "env"{
    default = "prd"
    type=string
}
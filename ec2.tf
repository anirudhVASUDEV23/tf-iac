#key-pair for login
resource aws_key_pair my_key {
    key_name="terra-key-ec2"
    public_key = file("terra-key-ec2.pub")
}

#vpc & security group
resource aws_default_vpc default {
    tags={
        Name="Default VPC"
    }
}

resource aws_security_group my_security_group {
    name = "automate-sg"
    description = "This will add a TF generated Security group"
    vpc_id =aws_default_vpc.default.id #interpolation

    #inbound rules
    ingress{
       from_port = 22
       to_port = 22
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"] ##ssh from anywhere
       description = "SSH Open"
    }

    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP OPEN"
    }

    ingress{
        from_port = 8000
        to_port = 8000
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "tcp"
        description = "Exposing An Application at this port"
    }

    #outbound rules
    egress{
       from_port = 0
       to_port = 0
       protocol = "-1"
       cidr_blocks = ["0.0.0.0/0"]
       description = "All Access Open"
    }

    tags = {
    Name = "automate-sg"
  }
}

#ec2 Instance

resource aws_instance my_instance {

        for_each = tomap({
        EC2_FIRST="t2.micro",
        EC2_SECOND="t2.medium"
    })#meta arguement,for suppose names of multiple instances should be different

    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = each.value
    ami= var.ec2_ami_id
    user_data =file("install_nginx.sh") 
    # #meta arguement this creates multiple instances 

    root_block_device{
        volume_size = var.ec2_root_storage_size
        volume_type = "gp3"
    }

    tags={
        Name=each.key
    }
}
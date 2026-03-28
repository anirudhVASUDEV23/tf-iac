output "ec2_pubic_ip"{
    # value=aws_instance.my_instance[*].public_ip ##when multiple instances and count meta arguement is used
    value=[
       for instance in aws_instance.my_instance:instance.public_ip
    ]
}

output "ec2_public_ip"{
    ##value=aws_instance.my_instance[*].public_dns
    value=[
        for instance in aws_instance.my_instance:instance.public_dns
    ]
}


output "ec2_private_ip"{
    #value=aws_instance.my_instance[*].private_ip
    value=[
        for instance in aws_instance.my_instance:instance.private_ip
    ]
}
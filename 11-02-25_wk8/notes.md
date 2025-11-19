class 7 (11-02-25)
week 8 Sunday

goal =

*******************************

VPC (Paris) = 10.109.0.0/16
                 eu-west-3

Public A = 10.109.1.0/24
Public B = 10.109.2.0/24
Public C = 10.109.3.0/24
Public D = 10.109.4.0/24

Private A = 10.109.11.0/24
Private B = 10.109.12.0/24
Private C = 10.109.13.0/24
Private D = 10.109.14.0/24

********************************

quick notes:

IVPAD
    terraform init
    terraform validate
    terraform plan
    terraform apply
    terraform destroy

*************************

SG to do
1) make SG
2) inbound rules (HTTP, SSH)
3) outbound rules (all protocols, all ports)


Push to my repository
    echo "# My-Class7-notes" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/DennistonShaw/My-Class7-notes.git
git push -u origin main

…or push an existing repository from the command line
git remote add origin https://github.com/DennistonShaw/testy-test.git
git branch -M main
git push -u origin main

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#argument-reference
EC2 settings I will edit in Terraform ec2
1) name tag
2) Amazon Linux
3) AMI (ami-09968b16214ef62ce)
4) Instance type - T3
5) Key Pair (come back later)
6) Network settings - choose terraform vpc, public subnet
7) Subnet - public
8) auto assign public IP
9) Security groups- we want it to have ping and select the created security group (web_server SGs)
10) Advance details - user data script
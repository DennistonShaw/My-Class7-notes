
*******************************

VPC (Virginia) = 10.71.0.0/16
                 us-east-1

Public A = 10.71.1.0/24
Public B = 10.71.2.0/24
Public C = 10.71.3.0/24
Public D = 10.71.4.0/24

Private A = 10.71.11.0/24
Private B = 10.71.12.0/24
Private C = 10.71.13.0/24
Private D = 10.71.14.0/24

IVPAD
    terraform init
    terraform validate
    terraform plan
    terraform apply
    terraform destroy

Push to my repository
    echo "# My-Class7-notes" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/DennistonShaw/My-Class7-notes.git
git push -u origin main
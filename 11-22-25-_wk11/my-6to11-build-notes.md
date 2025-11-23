Build Notes:
1) vpc and more (via terraform)
2) security group (via terraform)
3) ec2 (via terraform)
   
4) security group for load balancer 
   
#should I not include ping???????? was having a really slow spin up with pin included

   - to keep organized create a new 6a-lb-sg.tf file for the load balancer
   - copy from the original 6-sg.tf security group
      - change name of all resources so it's not duplicated
   - check the ports
      - erase ssh port 22 rule we don't need ssh for load balancer
      - erased sg for ping as well as to not duplicate
   
5) launch template
    - name launch template whatever you want
    - change to my AMI for my region (*located in AWS or in the ec2.tf)
    - instance type t3.micro 
    - key pair or key name - line comment it out for, not needed
    - copy the vpc_security_group_ids from ec2.tf and paste/replace into launch_template.tf
    - user_data = base64encode() replace it with user_data = base64encode(file("user_data.sh")) *our own code
    - tags= name, service, owner, planet
  
  for click-ops(
        - in network settings, do not associate a subnet or availability zone with the launch template. make sure they say "do not include in launch template"
        - don't touch security groups
        - ignore storage
        - in advanced details, make sure your script is how you want it to appeaar in the ASG. If it works already, no need to edit.)

6) target groups
   - change the resource name and name and tags
   - vpc _id
   - target type == instances
   - protocol == http
   - port == 80
   - ip address type == ipv4
   - make sure to select your custom VPC
   - health checks, don't touch

for click-ops(
   - on "register targets" screne, DO NOT SELECT ANY EC2s if available. scroll down and click the orange button.
   - on the next page, look over the settings, review your notes, and if everything aligns, click the orange button!)
  
7) load balancer
   - name, bla, bla, line 
   - comment out from aws_acm_certificate block to the end
   - check the subnets zones match in 02-subnets.tf
  
   - copied from Theo class 5 - change resource name, name, security_groups, AZs
   - choose application load balancer, per instructions of block captain Larry
   - scheme == internet facing
   - load balancer IP address type == ipv4
   - network mapping == custom VPC, select all AZs, and select PUBLIC subnets for each AZ
   - security group == delete default, and use the custom LB security group created previously
   - listener == http:80
   - default action == forward to TGs
   - target group == TG created today
   - review the summary, make sure that the subnets are pointed to public subnets, make sure the SG is going towards your load balancer SG, and that all 3 AZs are selected. Once ready click orange button!

11)  auto scaling group
   - name
   - check the AZ names
   - change the target_tracking_configuration block's target value to 50.0 instead of 75.0 percent
   - in the resource aws_autoscaling_attachement block in the last line with the error, need to delete the letter "a" at the beginning of the line

for click-ops(
   - launch template == select custom launch template, specify desired version, then click orange button
   - network == select custom VPC, and all PRIVATE subnets in your AZs, then click orange button
   - integrate with other services == choose "attach to existing load balancer," and choose accurate targeet group
   - health check == turn on ELB (elastisc load balancing) health checks, and leave grace period as default, then click orange button
   - configure group size and scaling == check scaling notes for the #s. select target tracking policy and use the defaults. once finished, click the orange button.
   - add notifications == will be used later. click orange button
   - tags == click orange button.
   - review == confirm that above config is applied to your ASG, then PRAY TO YOUR GOT OF UNDERSTANDING, and click orange button!)

to test go to load balancer, click on the name, copy the DNS name into a browser with http:// or copy the ld_dns_name  from the terminal

Teardown:
1) asg
2) load balancer listener
3) target groups
4) load balancer
5) launch template (optional)
6) EC2s (if any were manually created)
7) SGs (if any were manually created)
8) NAT gateway
9) Elastic IP
10) VPC
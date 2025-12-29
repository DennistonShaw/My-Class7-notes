# class 7 / Week 15 / (12/20/25) - Saturday
Youtube class recording: [Week 15 - Class 7 ZION: Yacht Party SAT DEC 20](https://youtu.be/PH-ooItQsA4?si=e5UpDUudabGUpqnT)
- week 15 (Terraform pt 9): 
- Adding HTTPS to ASG, S3 + CloudFront via clickOps (Route 53, hosted zones, and associated records, ACM)

goal = Configure a domain and affiliated records, build necessary infrastructure, and then attach a valid & issued certificate to an existing ASG or CloudFront distribution.

*** A domain costs money, so step by step participation for this lab is not necessary. what is necessary, is for you to take notes. Cheapest domain is $3/yr (*.click).

Homework == repo of notes and terraform code with updated infrastructure to build both an HTTP and HTTPS web application.

# What is HTTPS? -

(source: https://www.cloudflare.com/learning/ssl/what-is-https)

### Hypertext transfer protocol secure (HTTPS) is:
- the secure version of HTTP, which is the primary protocol used to send data between a web browser and a website. HTTPS is encrypted in order to increase security of data transfer. This is particularly important when users transmit sensitive data, such as by logging into a bank account, email service, or health insurance provider.

- Any website, especially those that require login credentials, should use HTTPS. In modern web browsers such as Chrome, websites that do not use HTTPS are marked differently than those that are. Look for a padlock in the URL bar to signify the webpage is secure(Google replaced it with a new, neutral "tune" icon (often looking like sliders or lines)). Web browsers take HTTPS seriously; Google Chrome and other browsers flag all non-HTTPS websites as not secure.

### Encryption In Flight 
- means when your moving data; like SSH it makes an encrypted tunnel, for you data to travel between my web browser and the webside

![non secure connection http](./screen-captures/1.png)
- note: when sending information to http your data can be intercepted because it is not a secure connection
- secured sites have a certificate; verification issued by a trusted authority
- this means information (such as passwords or credit cards) will be securely sent to this site and cannot be intercepted
- **Always be sure you're on the intended site before entering any information

### Transport Layer Security (TLS)/SSL (Secure Sockets Layer)
HTTPS uses an encryption protocol to encrypt communications over the internet. The protocol is called Transport Layer Security (TLS), although formerly it was known as Secure Sockets Layer (SSL). This protocol secures communications by using what’s known as an asymmetric public key infrastructure. This type of security system uses two different keys to encrypt communications between two parties. You need both keys for access.

1. The private key - this key is controlled by the owner of a website and it’s kept, as the reader may have speculated, private. This key lives on a web server and is used to decrypt information encrypted by the public key.
   
2. The public key - this key is available to everyone who wants to interact with the server in a way that’s secure. Information that’s encrypted by the public key can only be decrypted by the private key.

Asymmetric key encryption is like Lebron having a different handshake with each player

![handshake](./screen-captures/2.png)

# Websites using HTTP

HTTPS prevents websites from having their information broadcast in a way that’s easily viewed by anyone snooping on the network. When information is sent over regular HTTP, the information is broken into packets of data that can be easily “sniffed” using free software. This makes communication over HTTP an unsecure medium, such as public Wi-Fi, highly vulnerable to interception. In fact, all communications that occur over HTTP occur in plain text, making them highly accessible to anyone with the correct tools, and vulnerable to on-path attacks.

With HTTPS, traffic is encrypted such that even if the packets are sniffed or otherwise intercepted, they will come across as nonsensical characters. Let’s look at an example:

- Before encryption:
This is a string of text that is completely readable

- After encryption:
ITM0IRyiEhVpa6VnKyExMiEgNveroyWBPlgGyfkflYjDaaFf/Kn3bo3OfghBPDWo6AfSHlNtL8N7IT

### Another Vunerablility

it is possible for Internet service providers (ISPs) or other intermediaries to inject content into webpages without the approval of the website owner. This commonly takes the form of advertising, where an ISP looking to increase revenue injects paid advertising into the webpages of their customers. Unsurprisingly, when this occurs, the profits for the advertisements and the quality control of those advertisements are in no way shared with the website owner. HTTPS eliminates the ability of unmoderated third parties to inject advertising into web content.

![add vunerability](./screen-captures/3.png)


### A Port Is: 
-  a virtual software-based point where network connections start and end. All network-connected computers expose a number of ports to enable them to receive traffic. Each port is associated with a specific process or service, and different protocols use different ports.
- HTTPS use port 443
- HTTP uses port 80.

### How does a website start using HTTPS?
Many website hosting providers and other services will offer TLS/SSL certificates for a fee. These certificates will be often be shared amongst many customers. More expensive certificates are available which can be individually registered to particular web properties.

### Cloudflare
https://www.youtube.com/shorts/UbLx72J8C4c

All websites using Cloudflare receive HTTPS for free using a shared certificate (the technical term for this is a multi-domain SSL certificate). Setting up a free account will guarantee a web property receives continually updated HTTPS protection. You can also explore our paid plans for individual certificates and other features. In either case, a web property receives all the benefits of using HTTPS.

use a "AWS Certificate Manager" to use HTTPs in AWS. It creates certificates. To get a certificate you must first have a web domain

### Domain name: 
- A domain name is a human-friendly website address on the Internet, like google.com or wikipedia.org. It acts as a shortcut to complex IP addresses or long strings of numbers that computers use to locate websites on the web. By typing words instead of numbers into a browser, people can quickly reach websites and online services.

to see the real IP address you can ping the address in terminal
![ping cnn.com](./screen-captures/4.png)

### DNS
The Domain Name System (DNS) is the phonebook of the Internet. Humans access information online through domain names, like nytimes.com or espn.com. Web browsers interact through Internet Protocol (IP) addresses. DNS translates domain names to IP addresses so browsers can load Internet resources.

Each device connected to the Internet has a unique IP address which other machines use to find the device. DNS servers eliminate the need for humans to memorize IP addresses such as 192.168.1.1 (in IPv4), or more complex newer alphanumeric IP addresses such as 2400:cb00:2048:1::c629:d7a2 (in IPv6).

### DNS Record Types
source: https://en.wikipedia.org/wiki/List_of_DNS_record_types

Whenever a domain is created DNS Record Types are created. The information tells other computers, visitors, apps, devices, or web services how to interact with it.
There are many DNS types but we are only concerned with a few right now:

![DNS Types](./screen-captures/5.png)

|Type|Description|Function|
|---|---|---|
|A|IPv4 address Record|Returns a 32-bit IPv4 address, most commonly used to map hostnames to an IP address of the host
|AAAA|IPv6 address record|Returns a 128-bit IPv6 address, most commonly used to map hostnames to an IP address of the host.|
|CNAME|Canonical name|Alias of one name to another: the DNS lookup will continue by retrying the lookup with the new name.|
|SOA|Start of (a zone of) authority record|Specifies authoritative information about a DNS zone, including the primary name server, the email of the domain administrator, the domain serial number, and several timers relating to refreshing the zone.|
|TXT|Text record|human-readable text|
|NS|Name server record|Delegates a DNS zone to use the given authoritative name servers|

  
### What is an SSL certificate?
source: https://www.cloudflare.com/learning/ssl/what-is-an-ssl-certificate/

- An SSL certificate displays important information for verifying the owner of a website and encrypting web traffic with SSL/TLS, including the public key, the issuer of the certificate, and the associated subdomains.
  
### How do SSL certificates work?
SSL certificates include the following information in a single data file:

- The domain name that the certificate was issued for
- Which person, organization, or device it was issued to
- Which certificate authority issued it
- The certificate authority's digital signature
- Associated subdomains
- Issue date of the certificate
- Expiration date of the certificate
- The public key (the private key is kept secret)
  
The public and private keys used for SSL are essentially long strings of characters - used for encrypting and signing data. Data encrypted with the public key can only be decrypted with the private key.

The certificate is hosted on a website's origin server, and is sent to any devices that request to load the website. Most browsers enable users to view the SSL certificate: in Chrome, this can be donle by clicking on the padlock icon on the left side of the URL bar.

example of cyber attack
https://www.cshub.com/attacts/news/a-full-timeline-of-the-mgm-resorts-cyber-attack


### Goal: Configure a domain and affiliated records, build necessary infrastructure, and then attach a valid & issued certificate to an existing ASG or CloudFront distribution. 

*2:06:32 timestamp in [youtube link](https://youtu.be/PH-ooItQsA4?si=2DQLtJSV8C_d11kH)*

#### First step make sure ASG is up and running 
   
# 1. Register domain name with Amazon Route 53 
   - Your website needs a name, such as example.com. Route 53 lets you register a name for your website or web application, known as a domain name. 

|Source(s):|info links|
|---|---|
||[Amazon Route 53 - DNS Service - AWS](https://aws.amazon.com/route53/)|---|
||[Amazon Route 53 - Developer Guide - AWS](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/Welcome.html)|
 
#### Amazon Route 53 
provides highly available and scalable Domain Name System (DNS), domain name registration, and health-checking cloud services.

#### Registering a Domain
- go to the Rout 53 Dashboard in the console

![route 53 dashboard - aws](./screen-captures/6.png)

- is a global service
- by default it is set to Global which is actually us-east-1. all global routes go back to this
- register a domain name (must be unique)
- will show if the name is available, other prefix options ie. .inco, .co, .com, .io, ...
- will show the renewal price per year. will also show you a list of site names that will soon run out of renewal soon and can be cheaper
- note .click is usually the cheapest name
- create a hosted zone that you want to route traffic for
  
![registered domains](./screen-captures/7.png)

![confirm](./screen-captures/8.png)

After registering AWS will contact you to confirm you and your info. Make sure you respond to it confirming that you are the owner of the domain.

When you register a domain name directly with Amazon Route 53 (as the registrar), it automatically creates a Public Hosted Zone for that domain and assigns it unique Amazon Name Servers (NS records). This linking is automatic because Route 53 manages both the registration and the DNS service, so you can immediately start managing your DNS records in the new hosted zone. 
![Hosted Zone](./screen-captures/9.png)
![Hosted Zone](./screen-captures/10.png)
![Hosted Zone](./screen-captures/11.png)

*- for our purposes we only need 1 hosted zone. When registering a domain make sure the hosted zone names align*

When you create a hosted zone you automatically get 2 records:
1. NS Name Record 
2. SOA Start Of Authority Record  

Anything else you create is up to you and how you want to build out your infrastructure.

#### AWS Certificate Manager (ACM)
- After your Domain is purchased the Amazone Certificate manager (ACM) handles the public and private SSL and TLS certificates that will be put onto the server so we can protectSo we can protect our workflows with that encrypted traffic

- is a regional service, if you have multiple regions you have to make sure the certificates for your domain name is in each region that you have your infrastructure. You have to aquire the certificate for each.
  
![AWS Certificate Manager](./screen-captures/12.png)

Request a public certificate

![AWS Certificate Manager](./screen-captures/13.png)

![AWS Certificate Manager](./screen-captures/14.png)

Request public certificate > Domain names 
- You can add variations to your domain here
- can have as many variations as you want
- you can at *. as a wildcard which means it includes every name before the domain
- can also add different security to each one

![fully qualified domain name](./screen-captures/15.png)
Fully qualified domain name: here are parts that make up a URL but everything together that you can use to get you to the web address is a fully qualifited domain name

|example|term|
|---|---|
|https://|Protocol (Scheme)|
|.com|top level domain (TLD)|
|google|Second-Level Domain (SLD)|
|first.google.com|Hostname|
|mail.google.com|Hostname|
|accounting.google.com|Hostname|

Once you create the certificate it will say pending validation 
Next:Create records in Route 53
![fully qualified domain name](./screen-captures/16.png)

![fully qualified domain name](./screen-captures/17.png)

You want to create DNS records because it allows you to routing can happen right away without you having to do anything
![fully qualified domain name](./screen-captures/18.png)
- also keep in mind that DNS records certificates they are regional. They do not transfer from region to region.

![fully qualified domain name](./screen-captures/19.png)

*It takes a little while for the certs to be validated (10-15 min)*

*2:31:00 timestamp*
  
# 2. DNS Routing internet traffic to the resources of your domain
   - When a user opens a web browser and enters your domain name (example.com) or subdomain name (acme.example.com) in the address bar, Route 53 helps connect the browser with your website or web application.
  
#### Confirming certs work
- certs are regional, only work in the region it was created
- verify you certs exist
- make sure the certs work with your load balancer 
- time to build up more infrastructure 
  - build a web application that can work over port 443 which is basically building a new asg then attach the certificate you created to port 443 on the load balancer to ensure everything works
  
### a. Modify load balancer by adding HTTPS port 443 to the inbound rules to make sure the load balancer can receive traffic 

![asg inbound rules](./screen-captures/20.png)

### b. Create another security group for the port 443 application
   
![new securtiy group](./screen-captures/21.png)

![new security group](./screen-captures/22.png)
- SSH  
- HTTP - another option for health checks  
- HTTPS  
- Create Security Group
  
![new security group](./screen-captures/23.png)

### c. Create a new launch template

### d. Create a target group and attach it to the launch template

![create target group](./screen-captures/24.png)

![create target group](./screen-captures/25.png)
*port 80 is left on for health checks*

### e. Editing the (already built) load balancer

![editing the load balancer](./screen-captures/26.png)
  
![editing the load balancer](./screen-captures/27.png)
- go to listeners
- add HTTPS:443
  
![editing the load balancer](./screen-captures/28.png)

- choose the certificate that you created
- if you didn't create one already you can request one here
   
![default SSL/TLS server certificate](./screen-captures/29.png)

- add listener

![default SSL/TLS server certificate](./screen-captures/30.png)
 
### f. Go to ASG and create the Auto Scaling Group

![create ASG](./screen-captures/31.png)
- click next
  
![create ASG](./screen-captures/32.png)
- Network > VPC > choose your vpc
  
![create ASG](./screen-captures/33.png)
- Availability Zones and subnets
   - choose all private ie. (11, 12, 13)
  
![create ASG](./screen-captures/34.png)

- click next

Integrate with other services - optional  > Load Balancing
   - choose Attach to an existing load balancer

![choose existing load balancer](./screen-captures/35.png)

Existing load balancer target groups
 - select target group

![select target group](./screen-captures/36.png)

scroll to Health checks and check "Turn on Elastic Load Balancing health checks"

![turn on Health checks](./screen-captures/37.png)
*2:45:33 time stamp*
click next

Scaling 
![scaling](./screen-captures/38.png)
![choose target tracking scaling poliy](./screen-captures/39.png)

Instance maintenance policy
- If you're at the office you want to choose 'Prioritize availability > Launch before terminating' because you don't want your application to be torn down then try to rebuild it.
- but for our purposes of the lab be can choose 'Mixed behavior > no policy'
- *if you're in development environment you can terminate the launch to control costs, but in the production environment you want to make sure its working first before tearing old stuff down

![instance maintenance policy](./screen-captures/40.png)

click next

everything else as is
and go to review and make sure everything looks good

click > Create Auto Scaling group

We have one more record to create
go to Route 53 > refresh > Hosted zones

Here we have a few records here. These are the various subdomains/hostnames we created
each one is a different CNAME values

but here we are missing the A record because we have to attach the A record to the IP address

![create A record](./screen-captures/41.png)

you may see screen 1 (create record)

or screen 2 (wizard) then choose simple routing option and click next

|screen 1|screen 2|
|---|---|
|![create A record](./screen-captures/42.png)|![create A record](./screen-captures/43.png)|

Create record for Root domain
![create A record](./screen-captures/44.png)

In AWS we don't want to attached a specifited IP address; instead we want to use an alias
- Route Traffic to > 'Alias to application and Classic Load Balancer'
- Choose the region
- choose load balancer > now you Load Balancer will be an option in the dropdown menu

![create record](./screen-captures/45.png)
click Create records
![create record](./screen-captures/46.png)

view status
![create record](./screen-captures/47.png)

### review
- our NS and SOA records are created at the start
- CNAME records came from making a certificates in Certificate manager
- the final step was creating our A record to link our Root domain to our Load Balancer

![records](./screen-captures/48.png)

# 3. Health Checks - Check the health of your resources
- Route 53 sends automated requests over the internet to a resource, such as a web server, to verify that it's reachable, available, and functional. You also can choose to receive notifications when a resource becomes unavailable and choose to route internet traffic away from unhealthy resources.

# additional understanding
- https://www.cloudflare.com/learning/ssl/what-is-an-ssl-certificate/
- https://aws.amazon.com/certificate-manager/
- https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/Welcome.html
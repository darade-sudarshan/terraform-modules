# VPC limits and its components!

Know your limits before they limit you.
```
Note : use VPC designer tool for proper subnetting of IP addresses https://vpcdesigner.com/
```
1️⃣ VPC & Subnets

🚫 VPCs per Region = 05 (You can increase this limit so that you can have hundreds of VPCs per Region.)

🚫 Subnets per VPC = 200

🚫 IPv4 CIDR blocks per VPC = 05 (Adjustable up to 50)

🚫 IPv6 CIDR blocks per VPC = 05 (Adjustable up to 50)

2️⃣ Elastic IP addresses

🚫 Elastic IP addresses per Region = 05 (Adjustable = Yes)

🚫 Elastic IP addresses per public NAT gateway = 02 (Adjustable = Yes)

3️⃣ Gateways

🚫 Egress-only internet gateways per Region = 05 (Adjustable = Yes)

🚫 Internet gateways per Region = 05 (Adjustable = Yes)

🚫 NAT gateways per Availability Zone = 05 (Adjustable = Yes)

🚫 Private IP address quota per NAT gateway = 08 (Adjustable = Yes)

🚫 Carrier gateways per VPC = 01 (Adjustable = No)

4️⃣ Network ACLs

🚫 Network ACLs per VPC = 200 (Adjustable = Yes)

🚫 Rules per network ACL = 20 (Adjustable = Yes)

5️⃣ Network interfaces

🚫 Network interfaces per instance = Varies by instance type (Adjustable = No)

🚫 Network interfaces per Region = 5,000 (Adjustable = Yes)

6️⃣ Route tables

🚫 Route tables per VPC = 200 (Adjustable = Yes)

🚫 Routes per route table (non-propagated routes) = 50 (Adjustable = Yes)

🚫 Propagated routes per route table = 100 (Adjustable = No)

7️⃣ Security groups

🚫 VPC security groups per Region = 2,500 (Adjustable = Yes)

🚫 Inbound or outbound rules per security group = 60 (Adjustable = Yes)

🚫 Security groups per network interface = 05 (Adjustable = up to 16)

8️⃣ VPC subnet sharing

🚫 Participant accounts per VPC = 100 (Adjustable = Yes)

🚫 Subnets that can be shared with an account = 100 (Adjustable = Yes)

9️⃣ Network Address Usage

🚫 Network Address Usage = 64,000 (Adjustable up to to 256,000)

🚫 Peered Network Address Usage = 128,000 (Adjustable up to 512,000))

🔟 VPC peering connection

🚫 Active VPC peering connections per VPC = 50 (Adjustable up to 125)

🚫 Outstanding VPC peering connection requests = 25 (Adjustable = Yes)

1️⃣ 1️⃣ Site-to-Site VPN resources

🚫 Customer gateways per Region = 50 (Adjustable = Yes)

🚫 Virtual private gateways per Region = 05 (Adjustable = Yes)

🚫 Site-to-Site VPN connections per Region = 50 (Adjustable = Yes)

🚫 Site-to-Site VPN connections per virtual private gateway = 10 (Adjustable = Yes)

1️⃣ 2️⃣ AWS Client VPN quotas

🚫 Authorization rules per Client VPN endpoint = 50 (Adjustable = Yes)

🚫 Client VPN endpoints per Region = 05 (Adjustable = Yes)
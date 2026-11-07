High Availability K8S Cluster setup by Stacked Control Plane
----
Link: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/
  
  <img width="1013" height="652" alt="image" src="https://github.com/user-attachments/assets/3ddc59c1-e60f-487b-a15a-9858e86e8083" />

Inbound Rules for AWS Security Group  
---

EC2 Instance for haproxy security group 

  <img width="1913" height="646" alt="image" src="https://github.com/user-attachments/assets/39aa6f14-1c25-4928-8a49-ef0cac6b8b2d" />

EC2 Instance for master nodes security group

  <img width="1914" height="773" alt="image" src="https://github.com/user-attachments/assets/73af53f6-2bd2-4789-a79c-bb7eaeb238a4" />

EC2 Instance for worker nodes security group

  <img width="1915" height="750" alt="image" src="https://github.com/user-attachments/assets/c20014db-fe6b-4e2c-949a-7f654927678b" />


6 EC2 Instances ==> 1 - Load balancer ( haproxy setup ) 3 - Master Nodes 2 - Worker Nodes 

EC2 Instances:

<img width="1838" height="475" alt="image" src="https://github.com/user-attachments/assets/bfef468c-7b15-4252-87df-d38300933f63" />


**EC2 Instance - haproxy installation commands **
---

#apt update -y  ==> It is used on Debian/Ubuntu systems to refresh the local package index

#sudo apt install haproxy -y  ==> Install haproxy on ubuntu Linux system

#vi /etc/haproxy/haproxy.cfg

Add below details in the configuration file 

	frontend kubernetes_api
		bind *:6443
		mode tcp
		option tcplog
		default_backend k8s_masters

	backend k8s_masters
		mode tcp
		option tcplog
		balance roundrobin
		server master1 <master-node-1-private-ip-address>:6443 check
		server master2 <master-node-2-private-ip-address>:6443 check
		server master3 <master-node-3-private-ip-address>:6443 check

#sudo systemctl restart haproxy

#sudo systemctl enable haproxy

#sudo systemctl status haproxy

#nc -vz master-node-private-ip-address 6443  ==> to check connectivity 

check haproxy is connected to master nodes 
<img width="1822" height="701" alt="image" src="https://github.com/user-attachments/assets/903e42a9-90e5-4fbf-b9c5-5e832851244b" />


Master Nodes EC2 Instance:
---
Install pre-requisite for cluster setup in 3 EC2 InstanceS

Initiate kubeadm only in one master node and add master node token in other EC2 master nodes for high availability master nodes 

Command:
#sudo kubeadm init --control-plane-endpoint "LOAD_BALANCER_DNS:LOAD_BALANCER_PORT" --upload-certs

kubeadm init --control-plane-end-point load-balancer:6443 --upload-certs
					 ( or )
kubeadm init --control-plane-end-point load-balancer-private-ip-address:6443 --upload-certs
<img width="1670" height="836" alt="image" src="https://github.com/user-attachments/assets/42665835-af42-4fc5-a174-03aa1fe41a45" />

<img width="1499" height="935" alt="image" src="https://github.com/user-attachments/assets/ae46f6ab-246a-48ef-9a97-c91a4182543f" />

<img width="1338" height="94" alt="image" src="https://github.com/user-attachments/assets/933c50f8-74f8-481f-800d-9d7cadd8dafa" />









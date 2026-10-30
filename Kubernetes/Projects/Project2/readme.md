Links:
  High Availability for multi master node with Stacked control plane : https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/
  <img width="1013" height="652" alt="image" src="https://github.com/user-attachments/assets/3ddc59c1-e60f-487b-a15a-9858e86e8083" />

#load balancer Instance ( haproxy EC2 Instance - security group )
<img width="1913" height="646" alt="image" src="https://github.com/user-attachments/assets/39aa6f14-1c25-4928-8a49-ef0cac6b8b2d" />

Master Nodes Security group
<img width="1914" height="773" alt="image" src="https://github.com/user-attachments/assets/73af53f6-2bd2-4789-a79c-bb7eaeb238a4" />

Worker Nodes Security
<img width="1915" height="750" alt="image" src="https://github.com/user-attachments/assets/c20014db-fe6b-4e2c-949a-7f654927678b" />

6 EC2 Instances ==> 1 - Load balancer ( haproxy setup ) 3 - Master Nodes 2 - Worker Nodes 

EC2 Instances:
<img width="1838" height="475" alt="image" src="https://github.com/user-attachments/assets/bfef468c-7b15-4252-87df-d38300933f63" />

  Load balancer EC2 Instance ( haproxy )
  ============================================================================================================================
  load-balancer-instance==>history
  #customizing the shell prompt on your HAProxy EC2 node. It’s a cosmetic change so your terminal shows load-balancer-instance==> instead of the default ubuntu@ip-10-23.48.223
  1  PS1="lOad-balancer-instance==>"
  2  clear
  # It is used on Debian/Ubuntu systems to refresh the local package index
  3  apt update -y
        
  # Way to install HAProxy on an Ubuntu (Debian‑based) system.
  4  sudo apt install haproxy -y
  5  vi /etc/haproxy/haproxy.cfg
  Add below details in the configuration file 
  ------------------------------------------------  
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
  ----------------------------------------------------------------------
7  cat /etc/haproxy/haproxy.cfg
     <img width="1853" height="792" alt="image" src="https://github.com/user-attachments/assets/0ff2ac90-0151-4c11-8cea-340b419147c0" />   
8  sudo systemctl enable haproxy
9  sudo systemctl restart haproxy
10  sudo systemctl status haproxy
#To check connectivity status
nc -vz <master-node-private-ip-address> 6443
11  nc -vz 50.60.50.7 6443
12  kubectl get nodes
13  nc -vz 50.60.50.7 6443
14  kubectl get nodes
15  systemctl status haproxy
16  systemctl restart hxproxy
17  systemctl status haproxy
18  history
lOad-balancer-instance==>
=============================================================================================================================**

 External etcd topology:
 <img width="983" height="709" alt="image" src="https://github.com/user-attachments/assets/c5b57334-daac-4b5c-acf1-ec90008c9729" />

 

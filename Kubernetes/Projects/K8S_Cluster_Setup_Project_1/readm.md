**********	Execute below commands in all ETCD EC2 Instances **********

[ec2-user@ip-20-30-20-171 ~]$ sudo su
====
[root@ip-20-30-20-171 ec2-user]# yum update -y
Amazon Linux 2023 Kernel Livepa 865 kB/s |  97 kB     00:00
Last metadata expiration check: 0:00:01 ago on Sun Nov 15 07:55:54 2026.
Dependencies resolved.
Nothing to do.
Complete!
====
[root@ip-20-30-20-171 ec2-user]# hostnamectl set-hostname etcd1
[root@ip-20-30-20-171 ec2-user]# sudo reboot
====
[ec2-user@etcd1 ~]$ sudo su
====
[root@etcd1 ec2-user]# vi /etc/hosts
	20.30.20.171 etcd1
====
[root@etcd1 ec2-user]# URL=https://github.com/etcd-io/etcd/releases/download/v3.7.3/etcd-v3.7.3-linux-amd64.tar.gz
====
[root@etcd1 ec2-user]# curl -L -O $URL
  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
                                 Dload  Upload  Total   Spent   Left   Speed
  0      0   0      0   0      0      0      0                              0
100 22.83M 100 22.83M   0      0 112.5M      0                              0
====
[root@etcd1 ec2-user]# tar xvzf etcd-v3.7.3-linux-amd64.tar.gz
etcd-v3.7.3-linux-amd64/
etcd-v3.7.3-linux-amd64/Documentation/
etcd-v3.7.3-linux-amd64/Documentation/postmortems/
etcd-v3.7.3-linux-amd64/Documentation/postmortems/v3.5-data-inconsistency.md
etcd-v3.7.3-linux-amd64/Documentation/etcd-internals/
etcd-v3.7.3-linux-amd64/Documentation/etcd-internals/diagrams/
etcd-v3.7.3-linux-amd64/Documentation/etcd-internals/diagrams/write_workflow_leader.png
etcd-v3.7.3-linux-amd64/Documentation/etcd-internals/diagrams/write_workflow_leader.drawio
etcd-v3.7.3-linux-amd64/Documentation/etcd-internals/diagrams/write_workflow_follower.png
etcd-v3.7.3-linux-amd64/Documentation/etcd-internals/diagrams/write_workflow_follower.drawio
etcd-v3.7.3-linux-amd64/Documentation/etcd-internals/diagrams/etcd_internal_parts.png
etcd-v3.7.3-linux-amd64/Documentation/etcd-internals/diagrams/etcd_internal_parts.drawio
etcd-v3.7.3-linux-amd64/Documentation/etcd-internals/diagrams/consistent_read_workflow.png
etcd-v3.7.3-linux-amd64/Documentation/etcd-internals/diagrams/consistent_read_workflow.drawio
etcd-v3.7.3-linux-amd64/Documentation/dev-guide/
etcd-v3.7.3-linux-amd64/Documentation/dev-guide/apispec/
etcd-v3.7.3-linux-amd64/Documentation/dev-guide/apispec/swagger/
etcd-v3.7.3-linux-amd64/Documentation/dev-guide/apispec/swagger/v3lock.swagger.json
etcd-v3.7.3-linux-amd64/Documentation/dev-guide/apispec/swagger/v3election.swagger.json
etcd-v3.7.3-linux-amd64/Documentation/dev-guide/apispec/swagger/rpc.swagger.json
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/triage_prs.md
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/triage_issues.md
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/roadmap.md
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/reporting_bugs.md
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/release.md
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/prow_jobs.md
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/modules.svg
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/modules.md
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/modules-future.svg
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/logging.md
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/local_cluster.md
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/features.md
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/exit_codes.md
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/dependency_management.md
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/community-membership.md
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/cherry-pick.md
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/bump_etcd_version_k8s.md
etcd-v3.7.3-linux-amd64/Documentation/contributor-guide/branch_management.md
etcd-v3.7.3-linux-amd64/Documentation/README.md
etcd-v3.7.3-linux-amd64/Documentation/OWNERS
etcd-v3.7.3-linux-amd64/README-etcdutl.md
etcd-v3.7.3-linux-amd64/READMEv2-etcdctl.md
etcd-v3.7.3-linux-amd64/README-etcdctl.md
etcd-v3.7.3-linux-amd64/README.md
etcd-v3.7.3-linux-amd64/etcdutl
etcd-v3.7.3-linux-amd64/etcdctl
etcd-v3.7.3-linux-amd64/etcd
====
[root@etcd1 ec2-user]# cd etcd-v3.7.3-linux-amd64
[root@etcd1 etcd-v3.7.3-linux-amd64]# mv etcd etcdutl etcdctl /usr/bin
====
[root@etcd1 etcd-v3.7.3-linux-amd64]# etcd --version
etcd Version: 3.7.3
Git SHA: 0a173d0
Go Version: go1.26.10
Go OS/Arch: linux/amd64
====
[root@etcd1 etcd-v3.7.3-linux-amd64]# etcdctl version
etcdctl version: 3.7.3
API version: 3.7
====
[root@etcd1 etcd-v3.7.3-linux-amd64]# etcdutl version
etcdutl version: 3.7.3
API version: 3.7

**********		Execute below commands in one of the ETCD EC2 Instance 		**********

[root@etcd1 ec2-user]# cfssl=https://github.com/cloudflare/cfssl/releases/download/v1.7.1/cfssl_1.7.1_linux_amd64
====
[root@etcd1 ec2-user]# curl -L -O $cfssl
  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
                                 Dload  Upload  Total   Spent   Left   Speed
  0      0   0      0   0      0      0      0                              0
100 14.99M 100 14.99M   0      0 79.99M      0                              0
====
[root@etcd1 ec2-user]# ls
cfssl_1.7.1_linux_amd64  etcd-v3.7.3-linux-amd64  etcd-v3.7.3-linux-amd64.tar.gz
====
[root@etcd1 ec2-user]# mv cfssl_1.7.1_linux_amd64 cfssl
====
[root@etcd1 ec2-user]#chmod +x cfssl
====
[root@etcd1 ec2-user]# mv cfssl /usr/bin
====
[root@etcd1 ec2-user]# cfssl version
Version: 1.7.1
Runtime: go1.27.1
====
[root@etcd1 ec2-user]# cfssljson=https://github.com/cloudflare/cfssl/releases/download/v1.7.1/cfssljson_1.7.1_linux_amd64
====
[root@etcd1 ec2-user]# ls
etcd-v3.7.3-linux-amd64  etcd-v3.7.3-linux-amd64.tar.gz
====
[root@etcd1 ec2-user]# curl -L -O $cfssljson
  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
                                 Dload  Upload  Total   Spent   Left   Speed
  0      0   0      0   0      0      0      0                              0
100  9.67M 100  9.67M   0      0 60.52M      0                              0
====
[root@etcd1 ec2-user]# ls
cfssljson_1.7.1_linux_amd64  etcd-v3.7.3-linux-amd64  etcd-v3.7.3-linux-amd64.tar.gz
====
[root@etcd1 ec2-user]# chmod +x cfssljson_1.7.1_linux_amd64
====
[root@etcd1 ec2-user]# mv cfssljson_1.7.1_linux_amd64 cfssljson
====
[root@etcd1 ec2-user]# mv cfssljson /usr/bin
====
[root@etcd1 ec2-user]# cfssl version
Version: 1.7.1
Runtime: go1.27.1
====
[root@etcd1 cert_gen]# cat ca-config.json
{
  "signing": {
    "default": {
      "expiry": "8760h"
    },
    "profiles": {
      "kubernetes-etcd": {
        "usages": [
          "signing",
          "key encipherment",
          "server auth",
          "client auth"
        ],
        "expiry": "8760h"
      }
    }
  }
}
====
[root@etcd1 cert_gen]# cat ca-certs.json
{
  "CN": "etcd-ca",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "IN",
      "L": "Hyderabad",
      "O": "Kubernetes",
      "OU": "ETCD",
      "ST": "Telangana"
    }
  ]
}
====
[root@etcd1 cert_gen]# cat etcd-server-csr.json
{
  "CN": "etcd",
  "hosts": [
    "127.0.0.1",
    "20.30.20.171",
        "20.30.20.198",
        "20.30.20.141",
        "etcd1",
        "etcd2",
        "etcd3"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "IN",
      "L": "Hyderabad",
      "O": "Kubernetes",
      "OU": "ETCD",
      "ST": "Telangana"
    }
  ]
}
====
[root@etcd1 cert_gen]# cfssl gencert -initca ca-certs.json | cfssljson -bare ca
2026/11/15 10:22:38 [INFO] generating a new CA key and certificate from CSR
2026/11/15 10:22:38 [INFO] generate received request
2026/11/15 10:22:38 [INFO] received CSR
2026/11/15 10:22:38 [INFO] generating key: rsa-2048
2026/11/15 10:22:38 [INFO] encoded CSR
2026/11/15 10:22:38 [INFO] signed certificate with serial number 176380027241960367451362845186763636620505695661
====
[root@etcd1 cert_gen]# ls
ca-certs.json  ca-config.json  ca-key.pem  ca.csr  ca.pem  etcd-server-csr.json
====
[root@etcd1 cert_gen]# cfssl gencert -ca ca.pem -ca-key ca-key.pem -config ca-config.json -profile kubernetes-etcd etcd-server-csr.json | cfssljson -bare etcd
2026/11/15 10:25:24 [INFO] generate received request
2026/11/15 10:25:24 [INFO] received CSR
2026/11/15 10:25:24 [INFO] generating key: rsa-2048
2026/11/15 10:25:24 [INFO] encoded CSR
2026/11/15 10:25:24 [INFO] signed certificate with serial number 322608452175777291761829297828099461590539290939
[root@etcd1 cert_gen]#
====
[root@etcd1 cert_gen]# ls
ca-certs.json  ca-config.json  ca-key.pem  ca.csr  ca.pem  etcd-key.pem  etcd-server-csr.json  etcd.csr  etcd.pem
[root@etcd1 cert_gen]#
====
[root@etcd1 cert_gen]# cfssl gencert -ca ca.pem -ca-key ca-key.pem -config ca-config.json -profile kubernetes-etcd etcd-server.json | cfssljson -bare client
2026/11/15 10:33:45 [INFO] generate received request
2026/11/15 10:33:45 [INFO] received CSR
2026/11/15 10:33:45 [INFO] generating key: rsa-2048
2026/11/15 10:33:45 [INFO] encoded CSR
2026/11/15 10:33:45 [INFO] signed certificate with serial number 257069535603883595250466508300306154581766450564
2026/11/15 10:33:45 [WARNING] This certificate lacks a "hosts" field. This makes it unsuitable for
websites. For more information see the Baseline Requirements for the Issuance and Management
of Publicly-Trusted Certificates, v.1.1.6, from the CA/Browser Forum (https://cabforum.org);
specifically, section 10.2.3 ("Information Requirements").
[root@etcd1 cert_gen]#
====
[root@etcd1 cert_gen]# ls
ca-certs.json   ca-key.pem  ca.pem          client.csr  etcd-key.pem          etcd-server.json  etcd.pem
ca-config.json  ca.csr      client-key.pem  client.pem  etcd-server-csr.json  etcd.csr
====
**********	Execute Below commands in all ETCD Nodes	**********

[root@etcd1 cert_gen]# mkdir -p /etc/etcd/pki
[root@etcd1 cert_gen]# mkdir -p /var/lib/etcd
====
****Note: copy relevant certificates to remaining etcd nodes and move the file to this locatiom /etc/etcd/pki
ca-key.pem  
ca.pem  
client-key.pem  
client.pem  
etcd-key.pem  
etcd.pem

Update below details for etcd service to be cretaed 
====
ETCD_NAME=etcd1
ETCD_DATA_DIR=/var/lib/etcd
ETCD_LISTEN_PEER_URLS=https://10.0.0.31:2380
ETCD_INITIAL_ADVERTISE_PEER_URLS=https://10.0.0.31:2380
ETCD_LISTEN_CLIENT_URLS=https://10.0.0.31:2379,https://127.0.0.1:2379
ETCD_ADVERTISE_CLIENT_URLS=https://10.0.0.31:2379
ETCD_INITIAL_CLUSTER=etcd1=https://10.0.0.31:2380,etcd2=https://10.0.0.32:2380,etcd3=https://10.0.0.33:2380
ETCD_INITIAL_CLUSTER_TOKEN=etcd-cluster-01
ETCD_INITIAL_CLUSTER_STATE=new
ETCD_CERT_FILE=/etc/etcd/pki/server.pem
ETCD_KEY_FILE=/etc/etcd/pki/server-key.pem
ETCD_TRUSTED_CA_FILE=/etc/etcd/pki/ca.pem
ETCD_CLIENT_CERT_AUTH=true
ETCD_PEER_CERT_FILE=/etc/etcd/pki/peer.pem
ETCD_PEER_KEY_FILE=/etc/etcd/pki/peer-key.pem
ETCD_PEER_TRUSTED_CA_FILE=/etc/etcd/pki/ca.pem
ETCD_PEER_CLIENT_CERT_AUTH=true
====
****	ETCD EC2 Instance-1
[root@etcd1 ec2-user]#cd /etc/etcd
[root@etcd1 etcd]# vi ETCD_ENVFILE
ETCD_NAME=etcd1
ETCD_DATA_DIR=/var/lib/etcd
ETCD_LISTEN_PEER_URLS=https://20.30.20.171:2380
ETCD_INITIAL_ADVERTISE_PEER_URLS=https://20.30.20.171:2380
ETCD_LISTEN_CLIENT_URLS=https://20.30.20.171:2379,https://127.0.0.1:2379
ETCD_ADVERTISE_CLIENT_URLS=https://20.30.20.171:2379
ETCD_INITIAL_CLUSTER=etcd1=https://20.30.20.171:2380,etcd2=https://20.30.20.198:2380,etcd3=https://20.30.20.141:2380
ETCD_INITIAL_CLUSTER_TOKEN=etcd-cluster-01
ETCD_INITIAL_CLUSTER_STATE=new
ETCD_CERT_FILE=/etc/etcd/pki/etcd.pem
ETCD_KEY_FILE=/etc/etcd/pki/etcd-key.pem
ETCD_TRUSTED_CA_FILE=/etc/etcd/pki/ca.pem
ETCD_CLIENT_CERT_AUTH=true
ETCD_PEER_CERT_FILE=/etc/etcd/pki/etcd.pem
ETCD_PEER_KEY_FILE=/etc/etcd/pki/etcd-key.pem
ETCD_PEER_TRUSTED_CA_FILE=/etc/etcd/pki/ca.pem
ETCD_PEER_CLIENT_CERT_AUTH=true
====
[root@etcd1 cert_gen]# cd /etc/systemd/system
root@etcd2 ec2-user]# vi etcd.service
====
[root@etcd1 system]# cat etcd.service
[Unit]
Description=etcd key-value store
After=network-online.target
Wants=network-online.target

[Service]
Type=notify
User=root
EnvironmentFile=/etc/etcd/ETCD_ENVFILE

ExecStart=/usr/bin/etcd

Restart=always
RestartSec=5
LimitNOFILE=65536
====
[root@etcd1 system]# systemctl daemon-reload
[root@etcd1 system]# systemctl enable etcd
[root@etcd1 system]# systemctl start etcd
[root@etcd1 system]# systemctl status etcd

**** ETCD EC2 Instance-2
[root@etcd2 ec2-user]#cd /etc/etcd
[root@etcd2 etcd]# vi ETCD_ENVFILE
ETCD_NAME=etcd2
ETCD_DATA_DIR=/var/lib/etcd
ETCD_LISTEN_PEER_URLS=https://20.30.20.198:2380
ETCD_INITIAL_ADVERTISE_PEER_URLS=https://20.30.20.198:2380
ETCD_LISTEN_CLIENT_URLS=https://20.30.20.198:2379,https://127.0.0.1:2379
ETCD_ADVERTISE_CLIENT_URLS=https://20.30.20.198:2379
ETCD_INITIAL_CLUSTER=etcd1=https://20.30.20.171:2380,etcd2=https://20.30.20.198:2380,etcd3=https://20.30.20.141:2380
ETCD_INITIAL_CLUSTER_TOKEN=etcd-cluster-01
ETCD_INITIAL_CLUSTER_STATE=new
ETCD_CERT_FILE=/etc/etcd/pki/etcd.pem
ETCD_KEY_FILE=/etc/etcd/pki/etcd-key.pem
ETCD_TRUSTED_CA_FILE=/etc/etcd/pki/ca.pem
ETCD_CLIENT_CERT_AUTH=true
ETCD_PEER_CERT_FILE=/etc/etcd/pki/etcd.pem
ETCD_PEER_KEY_FILE=/etc/etcd/pki/etcd-key.pem
ETCD_PEER_TRUSTED_CA_FILE=/etc/etcd/pki/ca.pem
ETCD_PEER_CLIENT_CERT_AUTH=true
====
root@etcd2 ec2-user]# cd /etc/systemd/system
root@etcd2 ec2-user]# vi etcd.service
====
[root@etcd1 system]# cat etcd.service
[Unit]
Description=etcd key-value store
After=network-online.target
Wants=network-online.target

[Service]
Type=notify
User=root
EnvironmentFile=/etc/etcd/ETCD_ENVFILE

ExecStart=/usr/bin/etcd

Restart=always
RestartSec=5
LimitNOFILE=65536
====
[root@etcd2 system]# systemctl daemon-reload
[root@etcd2 system]# systemctl enable etcd
[root@etcd2 system]# systemctl start etcd
[root@etcd2 system]# systemctl status etcd
====
**** ETCD EC2 Instance-3
[root@etcd3 ec2-user]#cd /etc/etcd
[root@etcd3 etcd]# vi ETCD_ENVFILE
ETCD_NAME=etcd3
ETCD_DATA_DIR=/var/lib/etcd
ETCD_LISTEN_PEER_URLS=https://20.30.20.141:2380
ETCD_INITIAL_ADVERTISE_PEER_URLS=https://20.30.20.141:2380
ETCD_LISTEN_CLIENT_URLS=https://20.30.20.141:2379,https://127.0.0.1:2379
ETCD_ADVERTISE_CLIENT_URLS=https://20.30.20.141:2379
ETCD_INITIAL_CLUSTER=etcd1=https://20.30.20.171:2380,etcd2=https://20.30.20.198:2380,etcd3=https://20.30.20.141:2380
ETCD_INITIAL_CLUSTER_TOKEN=etcd-cluster-01
ETCD_INITIAL_CLUSTER_STATE=new
ETCD_CERT_FILE=/etc/etcd/pki/etcd.pem
ETCD_KEY_FILE=/etc/etcd/pki/etcd-key.pem
ETCD_TRUSTED_CA_FILE=/etc/etcd/pki/ca.pem
ETCD_CLIENT_CERT_AUTH=true
ETCD_PEER_CERT_FILE=/etc/etcd/pki/etcd.pem
ETCD_PEER_KEY_FILE=/etc/etcd/pki/etcd-key.pem
ETCD_PEER_TRUSTED_CA_FILE=/etc/etcd/pki/ca.pem
ETCD_PEER_CLIENT_CERT_AUTH=true
====
root@etcd3 ec2-user]# cd /etc/systemd/system
root@etcd3 ec2-user]# vi etcd.service
[root@etcd1 system]# cat etcd.service
[Unit]
Description=etcd key-value store
After=network-online.target
Wants=network-online.target

[Service]
Type=notify
User=root
EnvironmentFile=/etc/etcd/ETCD_ENVFILE

ExecStart=/usr/bin/etcd

Restart=always
RestartSec=5
LimitNOFILE=65536
====
[root@etcd3 system]# systemctl daemon-reload
[root@etcd3 system]# systemctl enable etcd
[root@etcd3 system]# systemctl start etcd
[root@etcd3 system]# systemctl status etcd
====
[root@etcd2 ec2-user]# etcdctl --endpoints=https://20.30.20.171:2379,https://20.30.20.198:2379,https://20.30.20.141:2379 --cacert=/etc/etcd/pki/ca.pem --cert=/etc/etcd/pki/client.pem --key=/etc/etcd/pki/client-key.pem endpoint health
https://20.30.20.171:2379 is healthy: successfully committed proposal: took = 14.422751ms
https://20.30.20.141:2379 is healthy: successfully committed proposal: took = 14.343084ms
https://20.30.20.198:2379 is healthy: successfully committed proposal: took = 19.998872ms
====


*********	Common Steps for Master Nodes and Worker Nodes EC2 Instance 	********

[ec2-user@ip-20-30-20-154 ~]$ sudo su
[root@ip-20-30-20-154 ec2-user]# hostnamectl set-hostname master-node-1
====
[root@ip-20-30-20-154 ec2-user]# vi /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost6 localhost6.localdomain6
20.30.20.171 etcd1
20.30.20.198 etcd2
20.30.20.141 etcd3
20.30.20.154 master-node-1
20.30.20.37 master-node-2
20.30.20.115 master-node-3
====
[root@ip-20-30-20-154 ec2-user]# sudo reboot
[ec2-user@master-node-1 ~]$ sudo su
[root@master-node-1 ec2-user]#
====
[root@master-node-1 ec2-user]#yum update -y 
[root@master-node-1 ec2-user]#swapoff -a
[root@master-node-1 ec2-user]#yum install -y iproute-tc
[root@master-node-1 ec2-user]#modprobe overlay
[root@master-node-1 ec2-user]#modprobe br_netfilter
====
[root@master-node-1 ec2-user]#cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
====
[root@master-node-1 ec2-user]#cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF
====
[root@master-node-1 ec2-user]#sysctl --system
[root@master-node-1 ec2-user]#CRIO_VERSION=v1.36
[root@master-node-1 ec2-user]#cat <<EOF | tee /etc/yum.repos.d/cri-o.repo
[cri-o]
name=CRI-O
baseurl=https://download.opensuse.org/repositories/isv:/cri-o:/stable:/$CRIO_VERSION/rpm/
enabled=1
gpgcheck=1
gpgkey=https://download.opensuse.org/repositories/isv:/cri-o:/stable:/$CRIO_VERSION/rpm/repodata/repomd.xml.key
EOF
====
[root@master-node-1 ec2-user]#KUBERNETES_VERSION=v1.36
[root@master-node-1 ec2-user]#cat <<EOF | tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/rpm/repodata/repomd.xml.key
EOF
====
[root@master-node-1 ec2-user]#yum install -y cri-o kubelet kubectl kubeadm
[root@master-node-1 ec2-user]#systemctl enable crio kubelet
[root@master-node-1 ec2-user]#systemctl start crio kubelet
====
********* HAProxy EC2 Instances Configuration common Steps 		*****************************

[ec2-user@ip-20-30-20-165 ~]$ sudo su
[root@ip-20-30-20-165 ec2-user]# hostnamectl set-hostname haproxy-1
[root@ip-20-30-20-165 ec2-user]# vi /etc/hosts
====
[root@ip-20-30-20-165 ec2-user]# cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost6 localhost6.localdomain6
20.30.20.171 etcd1
20.30.20.198 etcd2
20.30.20.141 etcd3
20.30.20.154 master-node-1
20.30.20.37 master-node-2
20.30.20.115 master-node-3
20.30.20.110 haproxy-1
20.30.20.165 haproxy-2
====
[root@ip-20-30-20-165 ec2-user]# sudo reboot
[ec2-user@haproxy-1 ~]$ sudo su
[root@haproxy-1 ec2-user]#
====
[root@haproxy-1 ec2-user]# yum install -y haproxy
Amazon Linux 2023 Kernel Livepatch repository                                                                            896 kB/s |  97 kB     00:00
Dependencies resolved.
 Package                         Architecture                   Version                                        Repository                           Size
Installing:
 haproxy                         x86_64                         3.0.30-1.amzn2023.0.1                          amazonlinux                         2.7 M

Transaction Summary
Install  1 Package

Total download size: 2.7 M
Installed size: 8.5 M
Downloading Packages:
haproxy-3.0.30-1.amzn2023.0.1.x86_64.rpm                                                                                  27 MB/s | 2.7 MB     00:00
Total                                                                                                                     18 MB/s | 2.7 MB     00:00
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                                 1/1
  Running scriptlet: haproxy-3.0.30-1.amzn2023.0.1.x86_64                                                                                            1/1
  Installing       : haproxy-3.0.30-1.amzn2023.0.1.x86_64                                                                                            1/1
  Running scriptlet: haproxy-3.0.30-1.amzn2023.0.1.x86_64                                                                                            1/1
  Verifying        : haproxy-3.0.30-1.amzn2023.0.1.x86_64                                                                                            1/1

Installed:
  haproxy-3.0.30-1.amzn2023.0.1.x86_64

Complete!
[root@haproxy-1 ec2-user]#
====
[root@haproxy-1 ec2-user]# systemctl enable haproxy
Created symlink /etc/systemd/system/multi-user.target.wants/haproxy.service → /usr/lib/systemd/system/haproxy.service.
====
Add below configuration details in /etc/haproxy/haproxy.cfg
[root@haproxy-1 ec2-user]# cat <<EOF | tee /etc/haproxy/haproxy.cfg
frontend apiserver
    bind *:6443
    mode tcp
    option tcplog
    default_backend apiserverbackend

backend apiserverbackend
    mode tcp
    balance roundrobin
    option httpchk

    http-check connect ssl
    http-check send meth GET uri /healthz
    http-check expect status 200

    server master1 20.30.20.154:6443 check verify none
    server master2 20.30.20.37:6443 check verify none
    server master3 20.30.20.115:6443 check verify none
EOF
====
[root@haproxy-1 ec2-user]# systemctl restart haproxy
====
[root@haproxy-1 ec2-user]# yum install keepalived -y
Last metadata expiration check: 0:54:06 ago on Sun Nov 15 12:50:07 2026.
Dependencies resolved.
 Package                                       Architecture              Version                                    Repository                      Size
Installing:
 keepalived                                    x86_64                    2.2.7-6.amzn2023.0.2                       amazonlinux                    551 k
Installing dependencies:
 libnftnl                                      x86_64                    1.2.2-2.amzn2023.0.2                       amazonlinux                     84 k
 mariadb-connector-c                           x86_64                    3.3.10-1.amzn2023.0.2                      amazonlinux                    211 k
 mariadb-connector-c-config                    noarch                    3.3.10-1.amzn2023.0.2                      amazonlinux                    9.3 k
 net-snmp-agent-libs                           x86_64                    1:5.9.3-2.amzn2023.0.4                     amazonlinux                    695 k
 net-snmp-libs                                 x86_64                    1:5.9.3-2.amzn2023.0.4                     amazonlinux                    740 k

Transaction Summary
Install  6 Packages

Total download size: 2.2 M
Installed size: 7.7 M
Downloading Packages:
(1/6): libnftnl-1.2.2-2.amzn2023.0.2.x86_64.rpm                                                                          3.0 MB/s |  84 kB     00:00
(2/6): mariadb-connector-c-3.3.10-1.amzn2023.0.2.x86_64.rpm                                                              6.6 MB/s | 211 kB     00:00
(3/6): mariadb-connector-c-config-3.3.10-1.amzn2023.0.2.noarch.rpm                                                       352 kB/s | 9.3 kB     00:00
(4/6): net-snmp-agent-libs-5.9.3-2.amzn2023.0.4.x86_64.rpm                                                                19 MB/s | 695 kB     00:00
(5/6): keepalived-2.2.7-6.amzn2023.0.2.x86_64.rpm                                                                        6.7 MB/s | 551 kB     00:00
(6/6): net-snmp-libs-5.9.3-2.amzn2023.0.4.x86_64.rpm                                                                      20 MB/s | 740 kB     00:00
Total                                                                                                                     14 MB/s | 2.2 MB     00:00
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                                 1/1
  Installing       : net-snmp-libs-1:5.9.3-2.amzn2023.0.4.x86_64                                                                                     1/6
  Installing       : mariadb-connector-c-config-3.3.10-1.amzn2023.0.2.noarch                                                                         2/6
  Installing       : mariadb-connector-c-3.3.10-1.amzn2023.0.2.x86_64                                                                                3/6
  Installing       : net-snmp-agent-libs-1:5.9.3-2.amzn2023.0.4.x86_64                                                                               4/6
  Installing       : libnftnl-1.2.2-2.amzn2023.0.2.x86_64                                                                                            5/6
  Installing       : keepalived-2.2.7-6.amzn2023.0.2.x86_64                                                                                          6/6
  Running scriptlet: keepalived-2.2.7-6.amzn2023.0.2.x86_64                                                                                          6/6
  Verifying        : keepalived-2.2.7-6.amzn2023.0.2.x86_64                                                                                          1/6
  Verifying        : libnftnl-1.2.2-2.amzn2023.0.2.x86_64                                                                                            2/6
  Verifying        : mariadb-connector-c-3.3.10-1.amzn2023.0.2.x86_64                                                                                3/6
  Verifying        : mariadb-connector-c-config-3.3.10-1.amzn2023.0.2.noarch                                                                         4/6
  Verifying        : net-snmp-agent-libs-1:5.9.3-2.amzn2023.0.4.x86_64                                                                               5/6
  Verifying        : net-snmp-libs-1:5.9.3-2.amzn2023.0.4.x86_64                                                                                     6/6

Installed:
  keepalived-2.2.7-6.amzn2023.0.2.x86_64                                   libnftnl-1.2.2-2.amzn2023.0.2.x86_64
  mariadb-connector-c-3.3.10-1.amzn2023.0.2.x86_64                         mariadb-connector-c-config-3.3.10-1.amzn2023.0.2.noarch
  net-snmp-agent-libs-1:5.9.3-2.amzn2023.0.4.x86_64                        net-snmp-libs-1:5.9.3-2.amzn2023.0.4.x86_64

Complete!
[root@haproxy-1 ec2-user]#
====
****** In First HAProxy EC2 Instance Node ***********************

[root@haproxy-1 ec2-user]# cat /etc/keepalived/check_haproxy.sh
#!/bin/bash

pidof haproxy >/dev/null 2>&1 || exit 1

if [ $? -ne 0 ]; then
    exit 1
fi

exit 0
====

[root@haproxy-1 ec2-user]# cat /etc/keepalived/keepalived.conf
global_defs {
    router_id HAPROXY_MASTER
}

vrrp_script chk_haproxy {
    script "/etc/keepalived/check_haproxy.sh"
    interval 2
    weight -20
    fall 2
    rise 2
}

vrrp_instance VI_1 {
    state MASTER
    interface ens5

    virtual_router_id 51

    priority 101
    advert_int 1

    authentication {
        auth_type PASS
        auth_pass K8SVIP123
    }

    virtual_ipaddress {
        20.30.20.100/24
    }

    track_script {
        chk_haproxy
    }
}
[root@haproxy-1 ec2-user]#
====
*****		BackUp Haproxy EC2 Instance   *****

[root@haproxy-2 ec2-user]# cat /etc/keepalived/check_haproxy.sh
#!/bin/bash

pidof haproxy >/dev/null 2>&1 || exit 1

if [ $? -ne 0 ]; then
    exit 1
fi

exit 0
====
[root@haproxy-2 ec2-user]# cat /etc/keepalived/keepalived.conf
global_defs {
    router_id HAPROXY_BACKUP
}

vrrp_script chk_haproxy {
    script "/etc/keepalived/check_haproxy.sh"
    interval 2
    weight -20
    fall 2
    rise 2
}

vrrp_instance VI_1 {
    state BACKUP
    interface ens5

    virtual_router_id 51

    priority 100
    advert_int 1

    authentication {
        auth_type PASS
        auth_pass K8SVIP123
    }

    virtual_ipaddress {
        20.30.20.100/24
    }

    track_script {
        chk_haproxy
    }
}
====
[root@haproxy-2 ec2-user]# systemctl daemon-reload
[root@haproxy-2 ec2-user]# systemctl start keepalived
====
For Virtual IP is created for keepalived service we need to add that IP Address in AWS Network Interface 
Steps: open AWS Console → EC2 Instances → select HAProxy EC2 Instances →  select Networking → Networking Interface → copy the Netwrok Interfaces
Click on Network Interfaces Service and select the required Netwrok Interface ( ENI - Elastic Network Interface ).
Select Actions → Manage IP addresses.
Click on check Box Allow Secondary private IPv4 addresses
Add IP Address in Interface netwrok
Enter:20.30.20.100
click on Save 
When we add virtual ip in other haproxy EC2 instance it will not allow to add in AWS to overcome this we will be creating NLB of haproxy ec2 nodes with out keepalved not been installed 
****Scenario: 
Physical Linux + Keepalived ✅ Works
VMware + Keepalived ✅ Works
AWS EC2 + Keepalived VIP ⚠️ Usually problematic unless integrated with AWS secondary IP/ENI failover or replaced with an NLB
====




***Note: Copy the etcd server certificate to all master nodes 
[root@etcd1 cert_gen]# scp -i server_login ca.pem client-key.pem client.pem ec2-user@20.30.20.154:/home/ec2-user
The authenticity of host '20.30.20.154 (20.30.20.154)' can't be established.
ED25519 key fingerprint is SHA256:NIUi410wyu8O71f7JxtsUANSgbm/QKW6hdfd0CU82oQ.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '20.30.20.154' (ED25519) to the list of known hosts.
client-key.pem                                                                                                                       100% 1675     3.5MB/s   00:00
client.pem                                                                                                                           100% 1407     2.9MB/s   00:00
====
[root@etcd1 cert_gen]# scp -i server_login ca.pem client-key.pem client.pem ec2-user@20.30.20.37:/home/ec2-user
The authenticity of host '20.30.20.37 (20.30.20.37)' can't be established.
ED25519 key fingerprint is SHA256:Zu+nXaNUQA2db5n0UiH36109/FsoeUAVp1GYWG1uol8.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '20.30.20.37' (ED25519) to the list of known hosts.
client-key.pem                                                                                                                       100% 1675     3.4MB/s   00:00
client.pem                                                                                                                           100% 1407     3.4MB/s   00:00
====
[root@etcd1 cert_gen]# scp -i server_login ca.pem client-key.pem client.pem ec2-user@20.30.20.115:/home/ec2-user
The authenticity of host '20.30.20.115 (20.30.20.115)' can't be established.
ED25519 key fingerprint is SHA256:Yhs0IFI/gdfEbiU4uOAZhQUb0H/qB8AMpOb0bc1dumA.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '20.30.20.115' (ED25519) to the list of known hosts.
client-key.pem                                                                                                                       100% 1675     3.1MB/s   00:00
client.pem                                                                                                                           100% 1407     1.7MB/s   00:00
[root@etcd1 cert_gen]#
====
**** Note: Copy the certificates to specific folder in all master nodes 
[root@master-node-1 ec2-user]# ls
client-key.pem  client.pem  common_steps.sh ca.pem
[root@master-node-1 ec2-user]# mkdir -p /etc/etcd/pki
[root@master-node-1 ec2-user]# cp *.pem /etc/etcd/pki

********* In one of the Master Node EC2 Instance to initlaize cluster  		********

**Note: update kubeadm config file 
[root@master-node-1 ec2-user]# cat kubeadm-config.yaml
apiVersion: kubeadm.k8s.io/v1beta4
kind: ClusterConfiguration

kubernetesVersion: v1.36.6

controlPlaneEndpoint: "20.30.20.100:6443"

networking:
  podSubnet: "20.30.0.0/16"

etcd:
  external:
    endpoints:
    - https://20.30.20.171:2379
    - https://20.30.20.198:2379
    - https://20.30.20.141:2379

    caFile: /etc/etcd/pki/ca.pem
    certFile: /etc/etcd/pki/client.pem
    keyFile: /etc/etcd/pki/client-key.pem
[root@master-node-1 ec2-user]#
====
[root@master-node-1 ec2-user]# kubeadm init --config kubeadm-config.yaml --upload-certs
[init] Using Kubernetes version: v1.36.6
[preflight] Running pre-flight checks
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action beforehand using 'kubeadm config images pull'
W1116 03:06:48.355196   86309 checks.go:907] detected that the sandbox image "registry.k8s.io/pause:3.10.1" of the container runtime is inconsistent with that used by kubeadm. It is recommended to use "registry.k8s.io/pause:3.10.2" as the CRI sandbox image.
[certs] Using certificateDir folder "/etc/kubernetes/pki"
[certs] Generating "ca" certificate and key
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local master-node-1] and IPs [10.96.0.1 20.30.20.154 20.30.20.100]
[certs] Generating "apiserver-kubelet-client" certificate and key
[certs] Generating "front-proxy-ca" certificate and key
[certs] Generating "front-proxy-client" certificate and key
[certs] External etcd mode: Skipping etcd/ca certificate authority generation
[certs] External etcd mode: Skipping etcd/server certificate generation
[certs] External etcd mode: Skipping etcd/peer certificate generation
[certs] External etcd mode: Skipping etcd/healthcheck-client certificate generation
[certs] External etcd mode: Skipping apiserver-etcd-client certificate generation
[certs] Generating "sa" key and public key
[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
[kubeconfig] Writing "admin.conf" kubeconfig file
[kubeconfig] Writing "super-admin.conf" kubeconfig file
[kubeconfig] Writing "kubelet.conf" kubeconfig file
[kubeconfig] Writing "controller-manager.conf" kubeconfig file
[kubeconfig] Writing "scheduler.conf" kubeconfig file
[control-plane] Using manifest folder "/etc/kubernetes/manifests"
[control-plane] Creating static Pod manifest for "kube-apiserver"
[control-plane] Creating static Pod manifest for "kube-controller-manager"
[control-plane] Creating static Pod manifest for "kube-scheduler"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/instance-config.yaml"
[patches] Applied patch of type "application/strategic-merge-patch+json" to target "kubeletconfiguration"
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Starting the kubelet
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests"
[kubelet-check] Waiting for a healthy kubelet at http://127.0.0.1:10248/healthz. This can take up to 4m0s
[kubelet-check] The kubelet is healthy after 729.364µs
[control-plane-check] Waiting for healthy control plane components. This can take up to 4m0s
[control-plane-check] Checking kube-apiserver at https://20.30.20.154:6443/livez
[control-plane-check] Checking kube-controller-manager at https://127.0.0.1:10257/healthz
[control-plane-check] Checking kube-scheduler at https://127.0.0.1:10259/livez
[control-plane-check] kube-controller-manager is healthy after 7.165116ms
[control-plane-check] kube-scheduler is healthy after 7.798679ms
[control-plane-check] kube-apiserver is healthy after 1.501906887s
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config" in namespace kube-system with the configuration for the kubelets in the cluster
[upload-certs] Storing the certificates in Secret "kubeadm-certs" in the "kube-system" Namespace
[upload-certs] Using certificate key:
7f41282b7ca29e4ee6f0e5602dd7db455dafe762c25e516e9d04b5dff03b196d
[mark-control-plane] Marking the node master-node-1 as control-plane by adding the labels: [node-role.kubernetes.io/control-plane node.kubernetes.io/exclude-from-external-load-balancers]
[mark-control-plane] Marking the node master-node-1 as control-plane by adding the taints [node-role.kubernetes.io/control-plane:NoSchedule]
[bootstrap-token] Using token: gy3bp6.l0989qxbp7wdni4p
[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to get nodes
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] Configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] Configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstrap-token] Configured RBAC rules to allow the API server kubelet client certificate to access the kubelet API
[bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
[kubelet-finalize] Updating "/etc/kubernetes/kubelet.conf" to point to a rotatable kubelet client certificate and key
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of control-plane nodes running the following command on each as root:

  kubeadm join 20.30.20.100:6443 --token gy3bp6.l0989qxbp7wdni4p \
        --discovery-token-ca-cert-hash sha256:d64cdc52d905e82b6f1de642aad457b865c24bae30abd7ed698ea9019a996a51 \
        --control-plane --certificate-key 7f41282b7ca29e4ee6f0e5602dd7db455dafe762c25e516e9d04b5dff03b196d

Please note that the certificate-key gives access to cluster sensitive data, keep it secret!
As a safeguard, uploaded-certs will be deleted in two hours; If necessary, you can use
"kubeadm init phase upload-certs --upload-certs" to reload certs afterward.

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 20.30.20.100:6443 --token gy3bp6.l0989qxbp7wdni4p \
        --discovery-token-ca-cert-hash sha256:d64cdc52d905e82b6f1de642aad457b865c24bae30abd7ed698ea9019a996a51
====
[root@master-node-1 ec2-user]# export KUBECONFIG=/etc/kubernetes/admin.conf
[root@master-node-1 ec2-user]# echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> .bash_profile
====
[root@master-node-1 ec2-user]# kubectl get nodes
NAME            STATUS     ROLES           AGE   VERSION
master-node-1   NotReady   control-plane   8h    v1.36.6
====
[root@master-node-1 ec2-user]# kubectl get nodes
NAME            STATUS     ROLES           AGE   VERSION
master-node-1   NotReady   control-plane   8h    v1.36.6
master-node-2   NotReady   control-plane   9s    v1.36.6
[root@master-node-1 ec2-user]#
====
[root@master-node-1 ec2-user]# kubectl get nodes
NAME            STATUS     ROLES           AGE     VERSION
master-node-1   NotReady   control-plane   8h      v1.36.6
master-node-2   NotReady   control-plane   8m38s   v1.36.6
master-node-3   NotReady   <none>          28s     v1.36.6  ==> ( Due to Free accountResource creation limt issue consider as worker node )
====
[root@master-node-1 ec2-user]# kubectl get pods -A
NAMESPACE     NAME                                    READY   STATUS    RESTARTS   AGE
kube-system   coredns-589f44dc88-dplx4                0/1     Pending   0          8h
kube-system   coredns-589f44dc88-nxswq                0/1     Pending   0          8h
kube-system   kube-apiserver-master-node-1            1/1     Running   3          8h
kube-system   kube-apiserver-master-node-2            1/1     Running   0          8m53s
kube-system   kube-controller-manager-master-node-1   1/1     Running   3          8h
kube-system   kube-controller-manager-master-node-2   1/1     Running   0          8m53s
kube-system   kube-proxy-5sq2c                        1/1     Running   0          43s
kube-system   kube-proxy-8blkq                        1/1     Running   0          8m53s
kube-system   kube-proxy-znn69                        1/1     Running   3          8h
kube-system   kube-scheduler-master-node-1            1/1     Running   3          8h
kube-system   kube-scheduler-master-node-2            1/1     Running   0          8m53s
====
[root@master-node-1 ec2-user]# kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.33.0/manifests/calico.yaml
poddisruptionbudget.policy/calico-kube-controllers created
serviceaccount/calico-kube-controllers created
serviceaccount/calico-node created
serviceaccount/calico-cni-plugin created
configmap/calico-config created
customresourcedefinition.apiextensions.k8s.io/bgpconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/bgpfilters.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/bgppeers.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/blockaffinities.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/caliconodestatuses.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/clusterinformations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/felixconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworksets.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/hostendpoints.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamblocks.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamconfigs.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamhandles.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ippools.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipreservations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/kubecontrollersconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networksets.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/stagedglobalnetworkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/stagedkubernetesnetworkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/stagednetworkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/tiers.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/clusternetworkpolicies.policy.networking.k8s.io created
clusterrole.rbac.authorization.k8s.io/calico-kube-controllers created
clusterrole.rbac.authorization.k8s.io/calico-node created
clusterrole.rbac.authorization.k8s.io/calico-cni-plugin created
clusterrole.rbac.authorization.k8s.io/calico-tier-getter created
clusterrolebinding.rbac.authorization.k8s.io/calico-kube-controllers created
clusterrolebinding.rbac.authorization.k8s.io/calico-node created
clusterrolebinding.rbac.authorization.k8s.io/calico-cni-plugin created
clusterrolebinding.rbac.authorization.k8s.io/calico-tier-getter created
daemonset.apps/calico-node created
deployment.apps/calico-kube-controllers created
[root@master-node-1 ec2-user]#
====
[root@master-node-1 ec2-user]# kubectl get pods -A
NAMESPACE     NAME                                       READY   STATUS    RESTARTS   AGE
kube-system   calico-kube-controllers-6ffffbccff-fqvxc   1/1     Running   0          83s
kube-system   calico-node-8vmdw                          1/1     Running   0          83s
kube-system   calico-node-hwfjw                          1/1     Running   0          83s
kube-system   calico-node-t2kgj                          1/1     Running   0          83s
kube-system   coredns-589f44dc88-dplx4                   1/1     Running   0          9h
kube-system   coredns-589f44dc88-nxswq                   1/1     Running   0          9h
kube-system   kube-apiserver-master-node-1               1/1     Running   3          9h
kube-system   kube-apiserver-master-node-2               1/1     Running   0          12m
kube-system   kube-controller-manager-master-node-1      1/1     Running   3          9h
kube-system   kube-controller-manager-master-node-2      1/1     Running   0          12m
kube-system   kube-proxy-5sq2c                           1/1     Running   0          4m11s
kube-system   kube-proxy-8blkq                           1/1     Running   0          12m
kube-system   kube-proxy-znn69                           1/1     Running   3          9h
kube-system   kube-scheduler-master-node-1               1/1     Running   3          9h
kube-system   kube-scheduler-master-node-2               1/1     Running   0          12m
[root@master-node-1 ec2-user]#
====
**** Kubeadm config file with loadbalancer  ****
Pre-requistic: Create load balancer for HAProxy EC2 instances 
	DNS Name update in controlPlaneEndPoint

[root@master-node-1 ec2-user]# cat kubeadm-confg-loadbalancer.yaml
apiVersion: kubeadm.k8s.io/v1beta4
kind: ClusterConfiguration

kubernetesVersion: v1.36.6

controlPlaneEndpoint: "haproxy-load-balancer-c720d76e92ed43fa.elb.us-east-1.amazonaws.com:6443"

networking:
  podSubnet: "20.30.0.0/16"

etcd:
  external:
    endpoints:
    - https://20.30.20.171:2379
    - https://20.30.20.198:2379
    - https://20.30.20.141:2379

    caFile: /etc/etcd/pki/ca.pem
    certFile: /etc/etcd/pki/client.pem
    keyFile: /etc/etcd/pki/client-key.pem
[root@master-node-1 ec2-user]#
====

**************************************************	 Backup ETCD Cluster 	****************************************
Healthly ETCD EC2 Instance 
====
[root@etcd1 ec2-user]# etcdctl --endpoints=https://20.30.20.171:2379,https://20.30.20.198:2379,https://20.30.20.141:2379 --cacert=/etc/etcd/pki/ca.pem --cert=/etc/etcd/pki/client.pem --key=/etc/etcd/pki/client-key.pem endpoint health
https://20.30.20.171:2379 is healthy: successfully committed proposal: took = 15.135766ms
https://20.30.20.141:2379 is healthy: successfully committed proposal: took = 14.962208ms
https://20.30.20.198:2379 is healthy: successfully committed proposal: took = 15.788882ms
====
[root@etcd1 ec2-user]# etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/etcd/pki/ca.pem --cert=/etc/etcd/pki/client.pem --key=/etc/etcd/pki/client-key.pem endpoint health
https://127.0.0.1:2379 is healthy: successfully committed proposal: took = 11.801884ms
[root@etcd1 ec2-user]#
====
 etcdctl --endpoints=https://20.30.20.171:2379,https://20.30.20.198:2379,https://20.30.20.141:2379 --cacert=/etc/etcd/pki/ca.pem --cert=/etc/etcd/pki/client.pem --key=/etc/etcd/pki/client-key.pem member list -w table
┌──────────────────┬─────────┬───────┬───────────────────────────┬───────────────────────────┬────────────┐
│        ID        │ STATUS  │ NAME  │        PEER ADDRS         │       CLIENT ADDRS        │ IS LEARNER │
├──────────────────┼─────────┼───────┼───────────────────────────┼───────────────────────────┼────────────┤
│ 315869f5291f7d8c │ started │ etcd2 │ https://20.30.20.198:2380 │ https://20.30.20.198:2379 │      false │
│ 6f1871fff14e00e5 │ started │ etcd3 │ https://20.30.20.141:2380 │ https://20.30.20.141:2379 │      false │
│ fe11a3689f060cc0 │ started │ etcd1 │ https://20.30.20.171:2380 │ https://20.30.20.171:2379 │      false │
└──────────────────┴─────────┴───────┴───────────────────────────┴───────────────────────────┴────────────┘

====

[root@etcd1 ec2-user]# etcdctl --endpoints=https://20.30.20.171:2379,https://20.30.20.198:2379,https://20.30.20.141:2379 --cacert=/etc/etcd/pki/ca.pem --cert=/etc/etcd/pki/client.pem --key=/etc/etcd/pki/client-key.pem endpoint status -w table
┌───────────────────────────┬──────────────────┬─────────┬─────────────────┬─────────┬────────┬───────────────────────┬────────┬───────────┬────────────┬───────────┬────────────┬────────────────────┬────────┬──────────────────────────┬───────────────────┐
│         ENDPOINT          │        ID        │ VERSION │ STORAGE VERSION │ DB SIZE │ IN USE │ PERCENTAGE NOT IN USE │ QUOTA  │ IS LEADER │ IS LEARNER │ RAFT TERM │ RAFT INDEX │ RAFT APPLIED INDEX │ ERRORS │ DOWNGRADE TARGET VERSION │ DOWNGRADE ENABLED │
├───────────────────────────┼──────────────────┼─────────┼─────────────────┼─────────┼────────┼───────────────────────┼────────┼───────────┼────────────┼───────────┼────────────┼────────────────────┼────────┼──────────────────────────┼───────────────────┤
│ https://20.30.20.171:2379 │ fe11a3689f060cc0 │   3.7.3 │           3.7.0 │  7.1 MB │ 2.2 MB │                   70% │ 2.1 GB │      true │      false │         2 │     157171 │             157171 │        │                          │             false │
│ https://20.30.20.198:2379 │ 315869f5291f7d8c │   3.7.3 │           3.7.0 │  7.1 MB │ 2.2 MB │                   69% │ 2.1 GB │     false │      false │         2 │     157171 │             157171 │        │                          │             false │
│ https://20.30.20.141:2379 │ 6f1871fff14e00e5 │   3.7.3 │           3.7.0 │  7.1 MB │ 2.2 MB │                   70% │ 2.1 GB │     false │      false │         2 │     157171 │             157171 │        │                          │             false │
└───────────────────────────┴──────────────────┴─────────┴─────────────────┴─────────┴────────┴───────────────────────┴────────┴───────────┴────────────┴───────────┴────────────┴────────────────────┴────────┴──────────────────────────┴───────────────────┘
[root@etcd1 ec2-user]#

****Note: leader=true , false=follower 
====







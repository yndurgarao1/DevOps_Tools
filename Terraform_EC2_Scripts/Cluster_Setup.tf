resource "aws_vpc" "K8S_VPC" {
        cidr_block = "10.20.0.0/16"
        instance_tenancy = "default"
        tags = {
                Name = "Terraform_K8S_VPC"
        }
}

resource "aws_internet_gateway" "K8S_IGW" {
  vpc_id = aws_vpc.K8S_VPC.id
  tags = {
      Name = "Terraform_K8S_IGW"
  }
}

resource "aws_subnet" "K8S_Public_Subnet" {
  vpc_id = aws_vpc.K8S_VPC.id
  cidr_block = "10.20.10.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Terraform_K8S_Public_Subnet"
  }
}

data "aws_route_table" "K8S_MRTB" {
  route_table_id = aws_vpc.K8S_VPC.main_route_table_id
}

resource "aws_route_table_association" "MRTB" {
  subnet_id = aws_subnet.K8S_Public_Subnet.id
  route_table_id = data.aws_route_table.K8S_MRTB.id
}

resource "aws_route" "IG_Attachment" {
  route_table_id  = data.aws_route_table.K8S_MRTB.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.K8S_IGW.id
}

# Security Group for SSH access
resource "aws_security_group" "K8S_SG" {
  name        = "K8S-SG"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.K8S_VPC.id

  # Inbound rule: allow SSH from anywhere (⚠️ restrict to your IP for security)
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Ingress: allow all protocols, all ports, all sources
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule: allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Terraform_K8S_SG"
  }
}

# EC2 Instance master node
resource "aws_instance" "K8S_EC2_Master_Node" {
  ami          					= "ami-0bdc7d025135d7b49"   
  instance_type 				= "t3.small"
  subnet_id     				= aws_subnet.K8S_Public_Subnet.id
  vpc_security_group_ids 		= [aws_security_group.K8S_SG.id]
  associate_public_ip_address 	= true   # Needed for internet access
  key_name 						= "July_North_Virginia"
  user_data = <<-EOF
              #!/bin/bash
              # Update system
              yum update -y

              # Install Docker
              yum install -y docker
              systemctl enable docker
              systemctl start docker

              # Disable swap
              swapoff -a
              sed -i '/ swap / s/^/#/' /etc/fstab

              # Configure Docker cgroup driver
              mkdir -p /etc/docker
              cat <<EOT > /etc/docker/daemon.json
              {
                "exec-opts": ["native.cgroupdriver=systemd"]
              }
              EOT
              systemctl restart docker

              # Install containerd
              yum install -y yum-utils device-mapper-persistent-data lvm2
              mkdir -p /etc/containerd
              containerd config default | tee /etc/containerd/config.toml
              sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
              systemctl restart containerd
              systemctl enable containerd

              # Add Kubernetes repo
              cat <<EOT > /etc/yum.repos.d/kubernetes.repo
              [kubernetes]
              name=Kubernetes
              baseurl=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/
              enabled=1
              gpgcheck=1
              gpgkey=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/repodata/repomd.xml.key
              exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
              EOT

              # Kernel params for networking
              cat <<EOT > /etc/sysctl.d/k8s.conf
              net.bridge.bridge-nf-call-ip6tables = 1
              net.bridge.bridge-nf-call-iptables = 1
              EOT
              sysctl --system

              # Disable SELinux
              setenforce 0
              sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

              # Install Kubernetes components
              yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
              systemctl enable kubelet
              systemctl start kubelet

              # Initialize cluster (only runs on first node)
              kubeadm init > /home/ec2-user/cluster_token.txt

              # Configure kubectl for root
              export KUBECONFIG=/etc/kubernetes/admin.conf
              echo 'export KUBECONFIG=/etc/kubernetes/admin.conf' >> .bash_profile

              # Apply Calico CNI
              kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.30.2/manifests/calico.yaml
              EOF  

  tags = {
    Name = "Terraform_K8S_EC2_Master_Node"
  }
}

#EC2 Instance Worker node 
resource "aws_instance" "K8S_EC2_Worker_Node" {
  ami                         = "ami-0bdc7d025135d7b49"   
  instance_type               = "t3.small"
  subnet_id                   = aws_subnet.K8S_Public_Subnet.id
  vpc_security_group_ids      = [aws_security_group.K8S_SG.id]
  associate_public_ip_address = true
  count                       = 2   # Creates 2 instances
  key_name 						= "July_North_Virginia"
  user_data = <<-EOF
              #!/bin/bash
              # Update system
              yum update -y

              # Install Docker
              yum install -y docker
              systemctl enable docker
              systemctl start docker

              # Disable swap
              swapoff -a
              sed -i '/ swap / s/^/#/' /etc/fstab

              # Configure Docker cgroup driver
              mkdir -p /etc/docker
              cat <<EOT > /etc/docker/daemon.json
              {
                "exec-opts": ["native.cgroupdriver=systemd"]
              }
              EOT
              systemctl restart docker

              # Install containerd
              yum install -y yum-utils device-mapper-persistent-data lvm2
              mkdir -p /etc/containerd
              containerd config default | tee /etc/containerd/config.toml
              sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
              systemctl restart containerd
              systemctl enable containerd

              # Add Kubernetes repo
              cat <<EOT > /etc/yum.repos.d/kubernetes.repo
              [kubernetes]
              name=Kubernetes
              baseurl=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/
              enabled=1
              gpgcheck=1
              gpgkey=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/repodata/repomd.xml.key
              exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
              EOT

              # Kernel params for networking
              cat <<EOT > /etc/sysctl.d/k8s.conf
              net.bridge.bridge-nf-call-ip6tables = 1
              net.bridge.bridge-nf-call-iptables = 1
              EOT
              sysctl --system

              # Disable SELinux
              setenforce 0
              sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

              # Install Kubernetes components
              yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
              systemctl enable kubelet
              systemctl start kubelet
              EOF 
  tags = {
    Name = "Terraform_K8S_EC2_Worker_Node_${count.index + 1}"
  }
}





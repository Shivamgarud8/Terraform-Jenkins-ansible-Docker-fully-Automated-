# 🚀 Docker Monitor – Fully Automated CI/CD Pipeline

<p align="center">
  <img src="https://img.shields.io/badge/CI%2FCD-Jenkins-blue?style=for-the-badge&logo=jenkins" />
  <img src="https://img.shields.io/badge/IaC-Terraform-623CE4?style=for-the-badge&logo=terraform" />
  <img src="https://img.shields.io/badge/Config-Ansible-black?style=for-the-badge&logo=ansible" />
  <img src="https://img.shields.io/badge/Container-Docker-2496ED?style=for-the-badge&logo=docker" />
  <img src="https://img.shields.io/badge/Cloud-AWS-FF9900?style=for-the-badge&logo=amazonaws" />
</p>

This project demonstrates a **production-style, fully automated DevOps workflow** using **Jenkins, Terraform, Ansible, Docker, and AWS**.

The entire pipeline runs from a **single Jenkins control server (Ubuntu)** and automatically:

- Provisions infrastructure on AWS using Terraform
- Configures the target EC2 instance using Ansible
- Builds and runs a Dockerized web application
- Requires **NO manual SSH**, **NO laptop involvement**, and **NO manual Docker commands**

---

## 🧠 High-Level Architecture

> **Note:** This architecture runs with **NO laptop involvement**. Jenkins, Terraform, and Ansible all run on a single Ubuntu control server.

### 📊 Architecture Diagram

> _(Add your generated architecture image here)_

```text
Jenkins (Ubuntu Control Server)
│
├── Terraform → AWS API → EC2 Creation
│
├── Ansible → SSH → Target EC2
│
└── Docker → Build & Run Application Container
```


```
Jenkins (Ubuntu Control Server)
│
├── Terraform → AWS API → EC2 Creation
│
├── Ansible → SSH → Target EC2
│
└── Docker → Build & Run Application Container
```

---

## 🛠️ Technology Stack

| Tool | Purpose |
|-----|--------|
| **Jenkins** | CI/CD Orchestration |
| **Terraform** | AWS Infrastructure Provisioning |
| **Ansible** | Configuration Management |
| **Docker** | Application Containerization |
| **AWS EC2** | Target Runtime Server |
| **Linux (Ubuntu)** | Jenkins Control Node |

---

## 📂 Project Structure

> Repository structure for the Docker Monitor application

```
docker-monitor/
├── app.py                # Flask application
├── requirements.txt      # Python dependencies
├── Dockerfile            # Docker image definition
├── templates/
│   └── index.html        # Web UI
├── static/
│   └── style.css         # Styling
└── README.md
```

### 📁 Jenkins Control Node Structure

```
/var/lib/jenkins/
├── workspace/merge4
└── terraform-projects/
    └── my-infra
```


```
docker-monitor/
├── app.py
├── requirements.txt
├── Dockerfile
├── templates/
│   └── index.html
├── static/
│   └── style.css
└── README.md
```

Terraform files live in:
```
/var/lib/jenkins/terraform-projects/my-infra
```

---

## 🔄 Complete Workflow (Step-by-Step)

### 📸 Screenshots (Optional)

> Add screenshots once deployed:

- Jenkins Pipeline Success Screen
- Terraform Apply Output
- Ansible Playbook Run
- Docker Container Running
- Web Application UI (`http://<EC2-IP>:5000`)

---


### 1️⃣ Jenkins Pipeline Trigger
- Manual trigger or Git push
- Jenkins runs as Linux user: `jenkins`

---

### 2️⃣ Terraform – Infrastructure Provisioning

Terraform performs:
- EC2 creation
- Security group creation
- Key pair usage
- Public IP allocation

Terraform authenticates using:
- AWS IAM Role **or**
- AWS credentials stored in Jenkins

✔ Terraform talks to **AWS API**, not to EC2 OS

---

### 3️⃣ Terraform Output → Jenkins

Jenkins dynamically fetches:
```
terraform output -raw public_ip
```

No hard-coded IPs are used.

---

### 4️⃣ Ansible Inventory Generation

Jenkins generates inventory dynamically:

```
[target]
<EC2-IP> ansible_user=ec2-user \
         ansible_ssh_private_key_file=terraform.pem \
         ansible_ssh_common_args="-o StrictHostKeyChecking=no"
```

---

### 5️⃣ Ansible – Target EC2 Configuration

Ansible connects via SSH:
```
Jenkins → SSH → ec2-user → sudo
```

Tasks performed:
- Install Docker
- Enable Docker service
- Prepare application directory

---

### 6️⃣ Docker Application Deployment

Ansible (with sudo) executes:

- `docker build`
- `docker run`

Container exposes:
```
http://<EC2-IP>:5000
```

---

## 🔐 Permission Model (IMPORTANT)

### 🟦 Jenkins Control Server

| Item | Permission |
|----|-----------|
| Jenkins workspace | jenkins user |
| Terraform files | jenkins |
| AWS credentials | Jenkins credentials |
| SSH key | Read-only |

### 🟩 Target EC2 Server

| Item | Owner |
|----|------|
| /opt directory | root |
| Docker service | root |
| Docker socket | root |
| Ansible execution | sudo |

Docker commands are executed **as root via Ansible become**.



## ✅ Why This Architecture Is Correct

- Fully automated
- Secure permission boundaries
- Reproducible infrastructure
- CI/CD best practices
- Interview & production ready

---

## 📌 One-Line Summary

> Jenkins orchestrates, Terraform provisions, Ansible configures, Docker runs — all automatically.

---

## 📈 Possible Enhancements

- HTTPS with ALB
- Blue/Green deployment
- Remote Terraform backend (S3 + DynamoDB)
- Monitoring with Prometheus & Grafana
- Secrets via AWS Secrets Manager

---

## 👨‍💻 Author

**Shivam Garud**  
DevOps Engineer | Cloud & Automation Enthusiast

---

⭐ If you found this project helpful, give it a star!



terraform folder : /var/lib/jenkins/terraform-projects/my-infra/
keypair :/var/lib/jenkins/terraform-projects/my-infra
yml file for ansible : /etc/ansible/playbooks/docker-installtiosn.yml


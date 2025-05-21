




<h1 align="center">☁️ DataHub Cloud Project</h1>
<p align="center">
  🚀 Cross-Bootcamp Collaboration • Deployed on Azure with Terraform & Docker
</p>



## 📌 About the Project

This project is part of a **Cross-Bootcamp Collaboration** between:
- 🧠 **Data Governance Team** (Data Consumers)
- 🛠️ **Cloud Engineering Team** (Infra & Automation)

Our mission: **Deploy DataHub** — a modern metadata platform — **on Microsoft Azure** using infrastructure as code and automation tools.

---

## 🧱 Infrastructure Overview

| Component        | Description                                 |
|------------------|---------------------------------------------|
| 🌐 VNet + Subnet | Secure, isolated virtual network             |
| 🔒 NSG           | Allows SSH (22) & DataHub UI (9002) only     |
| 🖥️ Ubuntu VM     | Provisioned with Docker & cloud-init         |
| 🐳 Docker        | Used to deploy DataHub components            |
| 🛢️ PostgreSQL    | Azure Flexible Server (metadata storage)     |
| 📦 Storage       | Optional: persistent storage (Blob/File)     |

---

## ⚙️ Technologies Used

- **Terraform** – Azure infrastructure as code
- **Docker & Compose** – Containerized DataHub services
- **Azure CLI** – Deployment and management
- **cloud-init** – VM bootstrap automation
- **GitHub** – Version control & collaboration

---

## 🚀 Quick Start

### 🏗️ Step 1: Deploy Infrastructure

```bash
terraform init
terraform apply
🔐 Requires a valid SSH key in ssh-keys/terraform-azure.pub

🔐 Step 2: Connect to the VM
bash


ssh -i ssh-keys/terraform-azure azureuser@<your-vm-public-ip>
🧰 Step 3: Launch DataHub
bash


cd ~/datahub/docker
docker-compose up -d
🖥️ UI available at: http://<your-ip>:9002

📁 Folder Structure
text


datahub-cloud-project/
│
├── main.tf                  # Terraform config (VM, VNet, DB)
├── script/
│   └── ustomdata.sh        # Auto-install script (cloud-init)
├── ssh-keys/
│   └── terraform-azure.pub  # Public SSH key
├── .gitignore
└── README.md
💡 Why This Matters
Metadata is the foundation of data discovery, quality, and governance.

With this setup, teams can:

📊 Scan & explore data assets

🏷️ Build business glossaries

🔎 Search metadata relationships

🔐 Collaborate securely on Azure

🧠 Team Reflection
💬 “This project taught us how to collaborate across teams, use infrastructure-as-code effectively, and deploy production-grade tools on cloud environments.”

🤝 Contributors
👤 You – Cloud Engineering Lead

👥 Cross Bootcamp Team – Data Governance & DevOps

🏁 Wrap-Up
✅ 100% Terraform automated

✅ Secure access with SSH + NSG

✅ Modular & scalable

✅ Perfect for enterprise adoption


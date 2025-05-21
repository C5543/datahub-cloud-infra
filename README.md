<h1 align="center">☁️ DataHub Cloud Project</h1>
<p align="center">
  🚀 Cross-Bootcamp Collaboration • Deployed on Azure with Terraform & Docker
</p>

---

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

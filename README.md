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

| Component        | Description                                  |
|------------------|----------------------------------------------|
| 🌐 VNet + Subnet | Secure, isolated virtual network             |
| 🔒 NSG           | Allows SSH (22) & DataHub UI (9002) only     |
| 🖥️ Ubuntu VM     | Provisioned with Docker & cloud-init          |
| 🐳 Docker        | Used to deploy DataHub components             |
| 🛢️ PostgreSQL    | Azure Flexible Server (metadata storage)      |
| 📦 Storage       | Optional: persistent storage (Blob/File)      |

---

## 🧱 Architecture Diagram

Here is the infrastructure architecture diagram for the DataHub Cloud Project:

<img src="https://github.com/user-attachments/assets/68807507-92ee-468e-96aa-77199c7258cf" width="600" />

---

## 🖥️ DataHub UI Screenshot

After accessing the VM via its public IP, here is a screenshot of the DataHub user interface:

<img src="https://github.com/user-attachments/assets/e9dca1d1-5637-4013-b52a-2d47e3387cef" width="400" />

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

```
🔐 Requires a valid SSH key in ssh-keys/terraform-azure.pub

🔐 Step 2: Connect to the VM
```bash
ssh -i ssh-keys/terraform-azure azureuser@<your-vm-public-ip>
```


🧰 Step 3: Launch DataHub
```bash
cd ~/datahub/docker
docker-compose up -d
```


🖥️ UI available at:
```
http://<your-vm-public-ip>:9002
```


🧪 Expected Outputs & Results
-Infrastructure provisioned within 5-10 minutes

- VM running with Docker containers active (check with docker ps)

- Accessible DataHub UI via browser

- Metadata scanning and search features functional

- Secure SSH and UI access controlled by NSG


💡 Why This Project Matters
Metadata is the foundation of data discovery, quality, and governance.

With this setup, teams can:

- 📊 Scan & explore data assets

- 🏷️ Build business glossaries

- 🔎 Search metadata relationships

- 🔐 Collaborate securely on Azure


🧠 Team Reflection
💬 “This project taught us how to collaborate across teams, use infrastructure-as-code effectively, and deploy production-grade tools on cloud environments.”


🧾 Additional Notes
Minimum requirements:

-Terraform v1.0+

-Docker v20+

-Azure CLI installed and logged in

-To stop DataHub containers, run:
```
docker-compose down
```

To destroy infrastructure:
```
terraform destroy
```

🏁 Wrap-Up
✅ 100% Terraform automated

✅ Secure access with SSH + NSG

✅ Modular & scalable

✅ Perfect for enterprise adoption

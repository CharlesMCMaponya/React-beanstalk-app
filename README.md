#  Full-Stack React App Deployment on AWS with Terraform (Elastic Beanstalk)

This project demonstrates how to deploy a **React web application** using **AWS Elastic Beanstalk** — all provisioned via **Terraform**. It's a real-world DevOps workflow combining Infrastructure as Code, automation, and cloud hosting.

>  This is part of a bigger journey where I’m building real infrastructure from scratch — from networking to deployment — using professional tools.

---

##  What Was Built

| Layer         | Stack / Service                           |
|---------------|--------------------------------------------|
| Frontend      | React App                                  |
| Deployment    | AWS Elastic Beanstalk                      |
| Platform      | Node.js 20 on Amazon Linux 2023            |
| IaC Tool      | Terraform                                  |
| Region        | `us-east-1`                                |
| Environment   | Single-instance Elastic Beanstalk          |

---

##  Architecture Overview

Local React App
↓
Terraform Provisions:
- Beanstalk App + Env
- IAM EC2 Role
- Node.js platform (Elastic Beanstalk)
↓
AWS Elastic Beanstalk
↓
React App Running in Public Environment

---

##  Tools & Services Used

- **React** – Frontend application
- **Terraform** – Automate AWS infrastructure
- **Elastic Beanstalk** – Application deployment & environment management
- **AWS IAM** – Role-based access control for EC2
- **Git + GitHub** – Version control & project tracking

---

## 📁 Project Structure
react-beanstalk-app/
├── app/ # React app source code
├── terraform/ # Terraform IaC to create Elastic Beanstalk app/env
└── README.md # Project story and documentation

---

## 🧠 Why I Built This

After setting up my own custom VPC on AWS (see previous project), I wanted to go further and **deploy an actual app**. Instead of clicking around in the AWS Console, I chose Terraform to:

- Automate infrastructure creation
- Build production-like deployment pipelines
- Deepen my understanding of cloud-native development

This is how engineers work in teams — scriptable, reusable, and versioned.

---

##  Terraform Setup

Navigate to the `terraform/` folder and run:

```bash
terraform init
terraform apply
When prompted, type yes to provision your environment.

Expected output:
application_name = "react-beanstalk-app"
beanstalk_env_name = "react-env"

How to Deploy the React App
After Terraform provisions the environment:

Go to AWS Console → Elastic Beanstalk → Environments → react-env

Upload your React app ZIP (production build from npm run build)

Wait for deployment → App will be live with a public URL

Clean Up (To Avoid Charges on Free Tier)
Once done:
terraform destroy
This removes all created resources.

👨‍💻 Author
Mosehla Charles Maponya
Cloud & DevOps Enthusiast
 



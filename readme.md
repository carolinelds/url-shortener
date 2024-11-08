# URL Shortener Application

Author: Caroline Lopes dos Santos

## Contents

| Content | Description | Path | 
| ---- | ---- | ---- |
| General overview | Concise explanation about the application's architecture and infrastructure | This README file |
| How to run | Instructions for how to configure the application both locally and on the cloud | This README file |
| Application | Simple application with Flask framework (I decided to challenge myself and this is my first Flask application). Encapsulates both a simple frontend and an API. | `flask_app/` | 
| Baseline IaC | Creates Terraform state S3 bucket, DynamoDB lock table and Terraform service roles | `ìnfrastructure/terraform/baselines/` |
| Main IaC | Creates EKS and associated resources | `ìnfrastructure/terraform/main/` |
| Terraform custom modules | 2 modules for baseline configurations, 1 module for WAFv2 (other community modules are used throughout the code) | `infrastructure/terraform/_modules` |
| Kubernetes manifests | Manifests needed to deploy the application on the EKS cluster | `infrastructure/manifests/` |
| GitHub Actions workflow | Simple pipeline used to build the application Docker image and save it in ECR | `.github/workflows/` |
| Images | The images used throughout this README file | `images/` |
| Next steps | Suggestions of improvement and next steps to optimize even further the application | This README file |



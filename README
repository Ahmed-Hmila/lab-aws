# AWS Serverless API – FastAPI, Lambda & Terraform

## 📝 Description
Ce projet met en place une API serverless sur AWS basée sur FastAPI, déployée sur AWS Lambda via Mangum et exposée par API Gateway. Une route asynchrone permet l’envoi de messages vers Amazon SQS, tandis que les autres routes exposent un CRUD utilisateur synchrone. L’infrastructure est entièrement déployée avec Terraform.

## 📦 Architecture
CLIENT
|
v
API GATEWAY
├── POST /submit ───▶ SQS ───▶ Lambda (async)
├── GET /users ───▶ Lambda (sync)
├── POST /users ───▶ Lambda (sync)
├── PUT /users/{id} ───▶ Lambda (sync)
└── DELETE /users/{id} ───▶ Lambda (sync)


POST /submit : envoie des messages vers une file SQS  
/users : API CRUD pour la gestion des utilisateurs  
Lambda + Mangum : permet d’exécuter FastAPI sur AWS Lambda  
Terraform : déploie API Gateway, Lambda, SQS et les rôles IAM  

## ⚙️ Variables Terraform importantes
queue_name : nom de la file SQS  
api_gateway_arn : ARN de l’API Gateway pour la politique SQS  
lambda_arn : ARN de la fonction Lambda  
apigw_sqs_role_arn : ARN du rôle IAM autorisant API Gateway à envoyer des messages vers SQS  

## 🚀 Déploiement
terraform init  
terraform plan  
terraform apply  

## 🔗 Endpoints & tests avec cURL
Définir l’URL de base :
BASE_URL=https://<ton-api-id>.execute-api.eu-west-3.amazonaws.com/prod  

GET /users  
curl -i $BASE_URL/users/  

GET /users/{id}  
curl -i $BASE_URL/users/1  

POST /users  
curl -i -X POST $BASE_URL/users/ \
-H "Content-Type: application/json" \
-d '{
  "name": "Alice",
  "email": "alice@example.com",
  "password": "password1"
}'

PUT /users/{id}  
curl -i -X PUT $BASE_URL/users/1 \
-H "Content-Type: application/json" \
-d '{
  "name": "Alice Updated",
  "email": "alice-updated@example.com"
}'

DELETE /users/{id}  
curl -i -X DELETE $BASE_URL/users/1  

POST /submit (SQS)  
curl -i -X POST $BASE_URL/submit \
-H "Content-Type: application/json" \
-d '{
  "type": "user_created",
  "user_id": 123,
  "email": "test@test.com"
}'

## 🛠️ Technologies utilisées
AWS Lambda, API Gateway (REST), Amazon SQS, FastAPI, Mangum, Terraform

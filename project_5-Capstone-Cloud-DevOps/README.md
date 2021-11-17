[![CircleCI](https://circleci.com/gh/Muchezz/Capstone-CloudDevOps/tree/main.svg?style=svg)](https://circleci.com/gh/Muchezz/Capstone-CloudDevOps/tree/main)

# Capstone-Cloud-DevOps
In this project I am applying the skills and knowledge which were developed throughout the Cloud DevOps Nanodegree program. These include:

Working in AWS
Using Circle CI to implement Continuous Integration and Continuous Deployment
Building pipelines
Working with Ansible and CloudFormation to deploy clusters
Building Kubernetes clusters
Building Docker containers in pipelines

# Steps in Completing the Project 

## Prerequisites
- AWS account
- A Circleci Account. In this configure
    - Add the AWS credentials as environment variables. Configure AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY and AWS_DEFAULT_REGIO
- Your App to deploy

## Tools
1. Circleci
2. Amazon Elastic Kubernetes Service (EKS)
3. Amazon Elastic Container Registry (ECR)
4. Kubernetes
5. CloudFormation

## Steps
1. Fork the project to your Github Account
2. Add the AWS credentials as environment variables. Configure 
 
  - AWS_ACCESS_KEY_ID, 
  - AWS_SECRET_ACCESS_KEY 
  - AWS_DEFAULT_REGION
  - AWS_ECR_ACCOUNT_URL 
   > The environment variable storing your Amazon ECR account URL that maps to an AWS account, e.g. {awsAccountNum}.dkr.ecr.us-west-2.amazonaws.com
 
3. Complete your Dockerfile to build the image of your app
4. Add Makefile for linting
5. Complete your  ``` .circleci/config.yml ```. Implement Build and deploy jobs with CircleCI AWS ECR and AWS EKS orbs.

    ```yml 
    orbs:
          aws-eks: circleci/aws-eks@1.1.0
          kubernetes: circleci/kubernetes@0.4.0
          aws-ecr: circleci/aws-ecr@7.2.0  
    ```
    
    - In the workflow segement , use the workflow ```aws-ecr/build-and-push-image``` to build and push your docker image to ecr.
    ```yml
    workflows:
    deployment:
        jobs:
        - linting
        - aws-ecr/build-and-push-image:
            account-url: AWS_ECR_URL
            aws-access-key-id: AWS_ACCESS_KEY_ID
            aws-secret-access-key: AWS_SECRET_ACCESS_KEY
            tag: ${CIRCLE_SHA1}
            requires:
                - linting 
    ```

    - Then use the workflow ```aws-eks/create-cluster``` to create the cluster and all the required VPC-related resources to run Kubernetes on AWS.
    - Lastly use the ```deploy-application:``` to deploy your application
6. Push your code to github and the pipeline will do the rest.


## Links
- [circleci/aws-ecr orb](https://circleci.com/developer/orbs/orb/circleci/aws-ecr).
- [circleci/aws-eks orb](https://circleci.com/developer/orbs/orb/circleci/aws-eks).



pipeline {
 agent any
}

environment {
 AWS_REGION='ap-south-1'
 PACKER_DIR = packer/
 TERRAFORM_DIR = terraform/

}

triggers{
pollSCM('* * * * *')
}

stages {

 stage('checkout-Branch'){
   steps{
      when{
       branch 'master'
      }    
   }

 }

 stage('checkout-code'){
  steps{
   checkout scm 

  }

 }

stage('building ami'){
   steps{
    dir("${PACKER_DIR}"){
     echo "building ami using packer"
     sh "packer init ."
     sh "packer build ."
     
    }
  }
 }

stage('building infra'){
  steps{
   dir("${TERRAFORM_DIR}"){
    echo "building infra"
    sh   "terraform init"
    sh  "terraform apply -auto-approve"
   }
  }
}

}

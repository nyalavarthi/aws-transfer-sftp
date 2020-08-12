<h2> This repo Creates AWS Transfer for SFTP solutions</h2>
Following resources will be created by the repo :
<ul>
    <li>AWS Transfer for SFTP</li>
    <li>S3 bucket </li>
    <li>SFTP User account </li>
    <li>S3 folder ( prefix) for each user account</li>
    <li>IAM role for the SFTP user account </li>
    
</ul>
terraform workspaces is impemented for this repo, refer to the variables.tf for env specific values. 

This project uses terrform workspaces - refer to this article if you are new to workspaces. - http://i-cloudconsulting.com/terraform-workspaces/


<p>
Terraform commands to run & apply the changes.

```
#initialize workspace
terraform init -backend-config=backends/dev-env.tf

#create / change workspace
terraform workspace new "dev"
#terraform workspace select "dev"

#plan and apply
terraform plan
terraform apply

```

Refer to this documentation for more details -> http://i-cloudconsulting.com/aws-transfer-for-sftp/


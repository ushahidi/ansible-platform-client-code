# ansible-platform-client-code

Simple role for deploying/building platform-client code to a server

## Manual

### Deployment flavors

Use the `platform_client_deploy_flavor` variable to select the deployment flavor of your choosing. Currently available:

- `pull-and-build`: pulls the source code from a github repository and builds it in the server (**requires node.js** in the server). Relevant variables:
    - `deploy_user`: user that will own the deployment folder
    - `platform_client_base_path`: deployment folder (defaults to `/var/www/platform-client`)
    - `platform_client_static_folder`: folder where the build process places the resulting files (defaults to `server/www`)
    - `platform_client_repo_url`: URL of the git repository to obtain the client source from
    - `platform_client_version`: version in the git repository to pull and build (defaults to `master`)
    - `platform_client_tx_username`: transifex user for pulling the latest translations during build
    - `platform_client_tx_password`: transifex password for pulling the latest translations during build
- `rsync`: synchronises SSH accessible server docroot with a successful build of the client (**requires rsync** in the host running the playbook)
    - `deploy_user`: user that will own the deployment / docroot folder
    - `platform_client_deploy_src`: locally (to the host running the playbook) available folder containing a succesful build of the client
    - `platform_client_docroot`: deployment folder (defaults to `/var/www/platform-client`)
- `s3-sync`: synchronises S3 bucket with a succcesful build of the client (**requires aws-cli** in the host running the playbook)
    - `platform_client_s3_dest_bucket`: destination bucket for the client
    - `platform_client_s3_dest_prefix`: path prefix within the bucket for writing the files
    - `platform_client_deploy_src`: locally (to the host running the playbook) available folder containing a succesful build of the client
    - `platform_client_aws_access_key_id`: AWS access key id for accessing the bucket (defaults to environment variable `AWS_ACCESS_KEY_ID`)
    - `platform_client_aws_secret_access_key`: AWS secret access key for accessing the bucket (defaults to environment variable `AWS_SECRET_ACCESS_KEY`)
    - `platform_client_aws_default_region`: region where the bucket is created (defaults to environment variable `AWS_DEFAULT_REGION`)
    - `platform_client_aws_cli`: aws-cli executable (defaults to `aws`)

The default flavor is `pull-and-build`.

Other common variables determine the contents of the client configuration files that are deployed. Check the [variable defaults file](defaults/main.yml) for a complete listing of variables

## Run tests

Using the `jet` utility from codeship:

        jet steps


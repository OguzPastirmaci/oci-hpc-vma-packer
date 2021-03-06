# Building an OCI HPC image with VMA

This is a CircleCI pipeline that uses Packer to build an OCI image.

### Create the following environment variables in CircleCI:

**USER_OCID**: ID of the user that Packer will use to connect to your tenancy

**TENANCY_OCID**: ID of your tenancy

**FINGERPRINT**: Fingerprint of the OCI API key to be used

**COMPARTMENT_OCID:** ID of the compartment to create the instance that will be used to create the image

**SUBNET_OCID:** ID of the subnet to deploy the instance that will be used to create the image

**BASE_IMAGE_OCID:** ID of the HPC base image (custom image) in your tenancy

**INSTANCE_SHAPE:** `BM.HPC2.36` for the bare metal HPC shape

**REGION:** Region to deploy the instance that will be used to create the image

**AVAILABILITY_DOMAIN:** Availability domain where you have limits to deploy instances with the INSTANCE_SHAPE

**OCI_API_KEY_ENCODED:** Base64 encoded string of your OCI API private key. You can use `cat <location of your API key> | base64 -b 0` in MacOS and `cat <location of your API key> | base64 -w 0` in Linux.


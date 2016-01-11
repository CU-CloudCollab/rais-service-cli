# RAIS - Service CLI Template


#### Table of Contents
1. [About](#about)
2. [Installation](#installation)
3. [Examples](#examples)

## About

This CLI template implements the rais-ecs-api gem to allow easy command-line interaction with services.  This is rather rough at the moment -- needs to be refactored into an independent gem (i.e., such that the base Microservice class can be inherited from any ruby file)


## Installation

Requirements:
  - Ruby 2.0+
  - Docker 1.7+
  - Docker Compose

First, Install required gems with Bundle

    $ bundle
    

Next, setup a service class (examples in example_services).  Set each of the options values appropriately (see lib/Microservice.rb for option descriptions).  **This is where you set the local repository name, remote repository name and server, AWS service names, etc.**

Next, modify project-cli-template and update the require_relative statements and class instantiations to include your specific services.

Finally, add a file named **.env** to the same folder where the project-cli lives.  Within it, define your docker registry username and password

    REGISTRY_USERNAME=
    REGISTRY_PASSWORD=

At RAIS, we version the CLI and the service class (extensions of Microservice) with the application code for the service. Something like this:

    \project
    	project-cli
    	.env
    	docker-compose.yml
    	\services
    		\service_one
    			Dockerfile
    			service_definition.rb
    			\app_code
    		\service_two
    			Dockerfile
    			service_definition.rb
    			\app_code
    			

## Examples

Once everything is set up:

    $ project-cli
    
    NAME
        project-cli - Microservice Build and Deploy Automation CLI

    SYNOPSIS
        project-cli [global options] command [command options] [arguments...]

    GLOBAL OPTIONS
        --help - Show this message

    COMMANDS
        build           - Build a container
    	cluster_details - Clusters and scaling groups associated with services
    	deploy          - Deploy a new microservice image
    	help            - Shows a list of commands or help for one command
    	images          - List microservice images in registry and local repository
    	logs            - Show microservice logs
    	push            - Push a local image to registry
    	scale           - Scale microservice
    	scale_group     - Scale cluster via scaling group (see cluster_details for groups)
    	services        - List microservices manged by this tool
    	status          - Display microservice status information
  

Each command follows format: project-cli [command] [service/target] [arguments]

For example, get status for a given service:

    $ project-cli status service-one
    
    **************************************
    Service: service-one
    **************************************
    Cluster Status:
    NAME      | STATUS | NODES
    ----------|--------|------
    TEST      | ACTIVE | 5    

    Service Status:
    NAME               | DESIRED_COUNT | PENDING_COUNT | RUNNING_COUNT | IMAGE                                            | CPU | MEMORY
    -------------------|---------------|---------------|---------------|--------------------------------------------------|-----|-------
    SERVICE-ONE        | 1             | 0             | 1             | docker.cucloud.net/service-one:69ba735a1716      | 100 | 120   

    Deployments:
    DATETIME            | STATUS  | DESIRED_COUNT | PENDING_COUNT | RUNNING_COUNT | IMAGE                                            | CPU | MEMORY
    --------------------|---------|---------------|---------------|---------------|--------------------------------------------------|-----|-------
    2016-01-06 17:10:17 | PRIMARY | 1             | 0             | 1             | docker.cucloud.net/service-one:69ba735a1716      | 100 | 120   

    Instances:
    ID         | TYPE     | LAUNCHED            | STATE   | IP                         
    -----------|----------|---------------------|---------|----------------------------
    i-2823bbd1 | t2.micro | 2015-12-07 21:11:45 | running | ip-10-00-00-00.ec2.internal				
    

Get service images:

    $ project-cli images service-one
    
    Time: 00:00:40 <====================================> 100% Getting Image Details
    Registry Images:
    IMAGE_ID     | TAG          | DIGEST                                                                  | CREATED             | LIVE
    -------------|--------------|-------------------------------------------------------------------------|---------------------|-----
    4d5fe6a21ccf | 6353fd0269   | sha256:59a201b228fe3f3f433dae157d3a0e1cf11b05272a26ac1f9511a95f168d1c94 | 2015-07-17 15:20:46 | No  
    a454acb8133b | f373fe6      | sha256:a31c61b477b14136ad9e6840c42a192042b5f5197da9daddfdc5dec3d3e40e28 | 2015-07-18 11:40:44 | No  
    4a9b82252e9b | 07a6281      | sha256:074b8f7cb2e74663e278e2164b8e59381ec19b37a193e9b4a7022c9d1b2791d2 | 2015-07-26 11:03:23 | No  
    b00bee5e1ca1 | 036695d      | sha256:3a310f83742f06a5a499854ecec32b2449214e17e6df689aa624247fbc5f0195 | 2015-07-30 11:07:28 | No  
    edd70344e5cd | 384948       | sha256:1d9d61a97778073136619789f5e48eb49b7f9ad982c98c39537ae7459bb32ef3 | 2015-08-03 09:40:25 | No  
    402cdb84e130 | 402cdb84e130 | sha256:86ffe769825f27a8fb09a72d73215ef6d674b7f4766b98050796bb631fe16714 | 2015-08-05 13:34:25 | No  
    b672211d5b70 | b672211d5b70 | sha256:ba932e56269464e678a5028f73cce8e3b9059a9e116c36de687d157881e3d4cc | 2015-08-07 13:05:32 | No  
    6f93bd082df8 | 6f93bd082df8 | sha256:09666a391edb8be44b5845925d5e890dec4a740e5a2f6554cf52813a7db6a514 | 2015-08-07 13:26:41 | No  
    c53564f9fb73 | c53564f9fb73 | sha256:afc9ad94f6e69a47328792eeafc0397a160a10017521220b4a9ea5303ab48bbf | 2015-08-09 12:09:01 | No  
    e7763ef8c236 | e7763ef8c236 | sha256:597c3f0fd8be127916ba04837440280a212740d16806485a9b843b0ac642bef1 | 2015-08-10 12:35:44 | No  
    2d51487beadc | 2d51487beadc | sha256:d48b37c955db04af9e163c7b4ef8ab450aa9dbd6a52c55956e750f9888f5bc11 | 2015-09-08 11:08:57 | No  
    0425bc269488 | 0425bc269488 | sha256:12efa2f511bf0b74c66c14bd6f910e0a9997fc7dffd8787492ff3f53160689df | 2015-10-10 16:43:21 | No  
    9b523ad862cc | 9b523ad862cc | sha256:f34fbe3afa3398b50fb2c41df2fdd56833ba5df03792ae8afa4ab52bee915731 | 2015-11-10 09:17:05 | No  
    a27dbbd20614 | a27dbbd20614 | sha256:ca163ef9ab8c83762329048a3158e5aa26fec32521960d246c19c8cd16c772cd | 2015-11-15 20:33:26 | No  
    0d7c06634def | 0d7c06634def | sha256:445c7b3bb2f66e666f673263e143c39dafe3c60ab12eed49c1f461b77bc107b1 | 2015-11-23 11:02:13 | No  
    e0b76bc58769 | e0b76bc58769 | sha256:a9e6c203826fad3fe4c738f2e0d36c724ca0b3986858ea680813d34cd06fc2f5 | 2015-12-02 11:27:50 | No  
    4bcf483c0286 | 4bcf483c0286 | sha256:cd05f4b55d3346c37d77f1bd414e58dc89a715d558edd8f5610add539d13e5f0 | 2015-12-02 13:08:16 | No  
    479abe4d309f | 479abe4d309f | sha256:c47c111e24bfb9f6127e60dc1c4e263a76db3b96470a13c4c2699e37f92e09b4 | 2015-12-02 15:38:31 | No  
    2a0d0403a967 | 2a0d0403a967 | sha256:7e6ff948e6e090fca45d8b76d49a1fa3979a6fe26bbab77bf694f53343f8455e | 2015-12-02 16:03:52 | No  
    3e7b516d1b5c | 3e7b516d1b5c | sha256:afd6665053d3931189b740771ccf65e9c368e7d7afb9ebf2f50de9c949159c4a | 2015-12-02 16:40:26 | No  
    442ae76ad195 | 442ae76ad195 | sha256:caa024fcbcb604e9977b1a361b552a2fb22bff1c1d9109cb66f90dffe6e3cd8f | 2015-12-07 11:44:12 | No  
    69ba735a1716 | 69ba735a1716 | sha256:322d1dd535a89a21ee03278708cae96b93acb1d2c738d2f032696449645138ab | 2015-12-08 13:25:09 | Yes 

    Local Images:
    IMAGE_ID     | TAG          | DIGEST | CREATED             | PUSHED
    -------------|--------------|--------|---------------------|-------
    98f606a3d01f | 69ba735a1716 | N/A    | 2015-12-10 17:22:12 | Yes 
    				


Get cluster and scaling group details:

    $ project-cli cluster_details
    
    Cluster Detail: 
    CLUSTER_NAME | SIZE | STATUS
    -------------|------|-------
    TEST-CLUSTER    | 4    | ACTIVE

    Nodes:
    ID         | TYPE     | LAUNCHED            | STATE   | IP                           | AVAILABILITY_ZONE | AUTOSCALING_GROUP | LAUNCH_CONFIGURATION          
    -----------|----------|---------------------|---------|------------------------------|-------------------|-------------------|----------------------
    i-f89dff01 | t2.micro | 2015-12-18 21:51:22 | running | ip-00-00-00-000.ec2.internal | us-east-1e        | TEST-GROUP        | TEST NODE CONFIG
    i-b8644508 | t2.micro | 2015-12-07 21:11:46 | running | ip-00-00-00-000.ec2.internal | us-east-1a        | TEST-GROUP        | TEST NODE CONFIG
    i-d1895162 | t2.micro | 2016-01-01 03:25:35 | running | ip-00-00-00-000.ec2.internal | us-east-1a        | TEST-GROUP        | TEST NODE CONFIG
    i-fd681f04 | t2.micro | 2016-01-02 04:55:28 | running | ip-00-00-00-000.ec2.internal | us-east-1e        | TEST-GROUP        | TEST NODE CONFIG

    Auto Scaling Groups:
    SCALING_GROUP_NAME | LAUNCH_CONFIGURATION           | MIN_NODES | MAX_NODES | DESIRED_NODES
    -------------------|--------------------------------|-----------|-----------|--------------
    PIDASH - Test      | TEST NODE CONFIG               | 0         | 5         | 4            



Build and push images:

    $ project-cli build service-one
   
    (docker build output)
   

Push an image to the remote registry:

    $ project-cli push service-one 98f606a3d01f


Deploy an image to ECS:

    $ project-cli deploy service-one sha256:322d1dd535a89a21ee03278708cae96b93acb1d2c738d2f032696449645138ab


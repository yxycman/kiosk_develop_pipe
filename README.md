# This repo will help you deploy:
* 3-node Consul cluster
* 3-node Docker swarm-mode cluster
* Docker registry
* Small Java app, which is built and packed to container. It shows you the name of container + few ENV variables
* Jenkins with build and deploy jobs for JAVA app
* Build agent for Jenkins
* Nginx to reverse-proxy all that stuff

## Requirements:
* Virtualbox
* Vagrant
* GIT
* Ansible 2.0.0.2

## Additional info:
* All persistent data saved to /data directory on Docker host nodes


Simplified schema
![d](https://raw.githubusercontent.com/yxycman/my_hub/master/ccluster1.png)

# After checking out repo, 
<https://github.com/yxycman/kiosk_develop_pipe>

### lets boot some VMachines
    vagrant up balancer1 cluster1 cluster2 cluster3
*this step will boot up 4 virtual machines with pre-configured IPs*


### and install some products
**consul install**

    ansible-playbook -i ansible/hosts/cluster.yml ansible/consul.yml -l consul -s
*this step will setup consul and put it into cluster. all nodes are masters*

**docker install**

    ansible-playbook -i ansible/hosts/cluster.yml ansible/docker.yml -l docker -s [ -e swarm_cluster=true ]
*this step will setup docker with docker swarm mode on all three nodes*
*we will need swarm cluster, so lets set* **swarm_cluster** to **true**

**registry install**

    ansible-playbook -i ansible/hosts/cluster.yml ansible/registry.yml -l balancer -s
*private registry will allow us save our containers in local network*

**build_agent install**

    ansible-playbook -i ansible/hosts/cluster.yml ansible/build_agent.yml -l balancer -s
*Jenkins agent installation with needed tools for building Java app*

**jenkins install**

    ansible-playbook -i ansible/hosts/cluster.yml ansible/jenkins.yml -l jenkins -s
*latest Jenkins container will be downloaded and bootstrapped with jobs for building and deploying Java application "HelloWorld"*

* Url to Jenkins is
<http://10.10.10.100:8080/>
* Jenkins login is admin\jenkins
* Java HelloWorld can be built and uploaded to registry with Jenkins job.
* Deployment of HelloWorld proceeds to whole Docker cluster. 
* Nodes are taken dynamically, depending on load and number of app replicas
* While deployment, Consul will register app and generate config for Nginx, Nginx will be reloaded
* Automatic application failure registration and generating action (for now messages added to logfile, but it is possible to send mail, execute script, etc)
* You need to configure Username and Password for accessing GitHub in Jenkins's "credentials/store/system/domain/_/credential/Auto_CTCO/update"

**nginx install**

    ansible-playbook -i ansible/hosts/cluster.yml ansible/nginx.yml -l balancer -s
*latest Nginx container will be bootstrapped with proxy configuration for:*

* http://10.10.10.100/ - Java application
* http://10.10.10.100:8500/ui/  - Consul cluster
* With Nginx installation, script for watching configuration changes are started in background. As soon as data changes in Consul, Nginx configs will be updated and Nginx reloaded.
* Script is also monitored by Consul, and if it became malfunction, event can be created.
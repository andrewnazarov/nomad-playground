nomad-playground
=====

!INCOMPLETE

Just 'vagrant up' and you'll get working infrastructure to play with containers. 
I'm not sure it's good enough, but pretty sure it's raw enough. So feel free to contribute.

Here we have:
* Vagrant to create VMs
* Ansible to provision our VMs
* Docker to run containers
* Consul to do service discovery
* Nomad to do scheduling and run jobs
* Fabio to do load balansing
* Dnsmasq to help resolving .service.consul requests

This envinronment was created under the influence of the following:

* http://sysadvent.blogspot.ru/2015/12/day-12-introduction-to-nomad.html (microbot service comes respectively from here)
* https://github.com/advantageous/vertx-node-ec2-eventbus-example/wiki/Setting-up-Nomad-and-Consul-in-EC2-instead-of-Mesophere
* https://blog.online.net/2016/09/14/build-your-infrastructure-with-terraform-nomad-and-consul-on-scaleway/
* http://www.smartjava.org/content/service-discovery-docker-and-consul-part-1
* https://www.codeproject.com/articles/1120830/multi-datacenter-container-orchestration-with-noma?msg=5302093
* https://github.com/oribaldi/nomad-cluster/tree/master/nomad-internals

I use a simple java app from here: https://github.com/hypergrid-inc/basic-docker-tomcat-example
 
TODO
-------

It's going to be a long list

Requirements
-----------------

It seems to work on the following configuration of local machine:

Virtualbox 4.3.36
Vagrant 1.6.5
Ansible 2.2.1.0

Howto
-----------------

0. git, virtualbox, vagrant and ansible must be installed

1. git clone

2. cd nomad-playground

3. vagrant up

4. vagrant ssh nomad-server1

5. cd /vagrant

6. nomad run fabio.nomad

7. nomad run microbot.nomad 

or/and

   nomad run tomcat.nomad

or/and

   nomad run mongo.nomad
   
8. curl 10.100.200.101:9999 -H "Host: microbot.service.consul"

or

   curl 10.100.200.101:9999 -H "Host: tomcat.service.consul"
   
Known bugs
----------------------

Domain name fabio.service.consul points to virtualbox's ip address 10.0.2.15. 
That way Fabio service registers itself in Consul.

License
---------

BSD

Author Information
----------------------

Andrew Nazarov

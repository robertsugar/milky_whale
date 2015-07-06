#Galaxy on Docker

##Why?

1. Independence from host OS, packages and libraries -> portability (PC, cluster, cloud)
2. Lightweight and transparent (dockerfile) compared to VMs
3. For reproducible distribution of a workflow (including datasets)

##How?

there are many ways to build a Galaxy docker image:

###a) roll your own (without dockerfile)
Ideally your image would be built using a dockerfile, we experiment here with the shell to understand what would be needed

-1. Create new docker image

```
sudo docker run -i -t --name=milky_whale ubuntu:14.04 /bin/bash
```

0. Install docker (Ubuntu example):

```
sudo apt-get update
sudo wget -qO- https://get.docker.com/ | sh
#alternatively you can install from package but that tends to be an older version 
#sudo apt-get install docker.io
```

1. Install Galaxy

```
sudo apt-get install git
sudo apt-get install python
#lynx for testing web interface
sudo apt-get install lynx

git clone https://github.com/galaxyproject/galaxy/
```

2. Run Galaxy

```
cd galaxy/
sh run.sh
```

3. Test Galaxy

#on a different shell from host

```
sudo docker ps
sudo docker exec my_container_id lynx 127.0.0.1:8080
```

4. Commit image

```
sudo docker commit -m "installed Galaxy" milky_whale milky_whale:v2
```

4. Commit image

```
sudo docker commit milky_whale milky_whale
sudo docker stop milky_whale
```

5. Test new instance
#run committed image

```
sudo docker run -i -t -p 8080 --name=milky2 milky_whale /bin/sh /galaxy/run.sh
```

#on a different shell
sudo apt-get lynx
lynx 127.0.0.1:8080


#b) start from a pre-canned one
Björn A. Grüning (bjoern.gruening@gmail.com) has kindly assembled a wide variety of Galaxy docker images available at: [https://github.com/bgruening/docker-galaxy-stable](https://github.com/bgruening/docker-galaxy-stable) and [https://github.com/bgruening/docker-recipes/](https://github.com/bgruening/docker-recipes/)

A good description, and a tutorial could be found on the GitHub page. Also worth looking into the [Dockerfile](https://github.com/bgruening/docker-galaxy-stable/blob/master/galaxy/Dockerfile) on how the docker image was built.

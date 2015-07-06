#Galaxy on Docker

##Why?

1. Independence from host OS, packages and libraries -> portability (PC, cluster, cloud)
2. Lightweight and transparent (dockerfile) compared to VMs
3. For reproducible distribution of a workflow (including datasets)

##How?

there are many ways to build a Galaxy docker image:

###a) roll your own (without dockerfile)
Ideally your image would be built using a dockerfile, we experiment here with the shell to understand what would be needed

Step 1. Install docker (Ubuntu example):

```
sudo apt-get update
sudo wget -qO- https://get.docker.com/ | sh
#alternatively you can install from package but that tends to be an older version 
#sudo apt-get install docker.io
```

Step 2. Create new docker image

```
sudo docker run -i -t --name=milky_whale ubuntu:14.04 /bin/bash
```


Step 3. Install Galaxy

```
sudo apt-get install git
sudo apt-get install python
#lynx for testing web interface
sudo apt-get install lynx

git clone https://github.com/galaxyproject/galaxy/
```

Step 4. Run Galaxy

```
cd galaxy/
sh run.sh
```

Step 5. Test Galaxy

on a different shell from host

```
sudo docker ps
sudo docker exec my_container_id lynx 127.0.0.1:8080
```

Step 6. Commit image

```
sudo docker commit -m "installed Galaxy" milky_whale milky_whale:v2
sudo docker stop milky_whale
```

Step 7. Test new instance
run committed image

```
sudo docker run -i -t -p 8080 --name=milky2 milky_whale /bin/sh /galaxy/run.sh
```

on a different shell
```
sudo apt-get lynx
lynx 127.0.0.1:8080
```

#b) Roll your own (with Dockerfile)

here we will do something similar as in a) in an automated manner

Create a new directory my_galaxy
```
mkdir my_galaxy
```

Download Galaxy (will be added to the docker image)
```
git clone https://github.com/galaxyproject/galaxy/
```

Create Dockerfile
```
nano Dockerfile
```

Step 1. Define base image 
Step 2. Update packages
Step 3: Add the package verification key
```
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
```
Step 4: Install packages git, python and lynx (Hint: use the apt-get -y flag for auto)


A possible solution: [Dockerfile](https://github.com/robertsugar/milky_whale/blob/master/Dockerfile)

build docker image from dockerfile
```
sudo docker build -t my_galaxy .
```
#c) start from a pre-canned one
Björn A. Grüning (bjoern.gruening@gmail.com) has kindly assembled a wide variety of Galaxy docker images available at: [https://github.com/bgruening/docker-galaxy-stable](https://github.com/bgruening/docker-galaxy-stable) and [https://github.com/bgruening/docker-recipes/](https://github.com/bgruening/docker-recipes/)

A good description, and a tutorial could be found on the GitHub page. Also worth looking into the [Dockerfile](https://github.com/bgruening/docker-galaxy-stable/blob/master/galaxy/Dockerfile) on how the docker image was built.

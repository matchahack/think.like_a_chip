# Install

> [install docker desktop](https://www.docker.com/)

# Build

> Build image
```
cd /home/$USER/think.like_a_chip/DEPS/Docker/
docker build --no-cache -t bsides_bristol_matchahack_img .
```

> Run image
```
docker images
docker run -it <IMAGE_ID>
```

# Run

## Intial build

> Copy files to docker container
```
docker ps
docker cp src <CONTAINER_ID>:/root/bsides_bristol_matchahack
```

> run in container
```
cd src 
make build
```

![guide](./guide.png)
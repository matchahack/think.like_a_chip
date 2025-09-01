# Error

> [!IMPORTANT]
> This example is a simple traffic light design, can you spot the bug?

> [!NOTE]
> One button starts the traffic light, the other will reset the progam (RED led active). Experiment to see which button does what!

> [!TIP]
> Run the following from your terminal to build and load the design to your FPGA:

> Copy files to container
```
docker ps
docker cp src <CONTAINER_ID>:/root/
```

> run in container
```
cd src 
make build && make load
```

![guide](../0_GETTING_STARTED/guide.png)
# Blink

> [!NOTE]
> The `buttons on the tang-nano` will make the `lights switch`!

> [!TIP]
> Run the following from your terminal to build and load the design to your FPGA:

# Run

> Run the following from `wsl` to copy the source files to your container:
```
docker ps
docker cp src <CONTAINER_ID>:/root/bsides_bristol_matchahack
```

> Now in your container, run the following to program the FPGA:
```
cd src 
make build && make load
```

![guide](../DEPS/guide.png)
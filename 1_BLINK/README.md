# Blink

> [!NOTE]
> The `buttons on the tang-nano` will make the `lights switch`!

> [!TIP]
> Run the following from your terminal to build and load the design to your FPGA:

# Run

> Run the following from `wsl` to copy the source files to your container:
```
cd /home/$USER/think.like_a_chip/1_BLINK/
docker cp src $(docker ps -q --filter "ancestor=bsides_bristol_think_like_a_chip"):/root/bsides_bristol_matchahack
```

> Now in your container, run the following to program the FPGA:
```
cd src 
make build && make load
```

![guide](../0_GETTING_STARTED/guide.png)
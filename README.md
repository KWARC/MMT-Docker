# MMT-Docker

This respository contains a [Dockerfile](https://www.docker.com) for MMT. 
It is approximatly 135 MB in size and published as `kwarc/mmt` under DockerHub. 

## How to use

```
    docker run --rm -v mmt:/content/ -p 8080:8080 -t -i kwarc/mmt
```

This will run the newest MMT.jar and store all archives inside a new volume called mmt mounted under `/content/`. 
The command can be run multiple times to (re-)start the container if neccessary. 

## File Structure & Configuration

Inside the Image, the mmt.jar is stored under `/root/MMT/deploy/mmt.jar`. 

Because of the default MMT file structure, this means that MMT expects archives under `/root/content/MathHub` and a configuration file under `/root/MMT/mmtrc`. 
To this end, a docker volume is mounted under `/config/`.
The `/root/content` folder is symlinked to it. Furthermore, `/root/MMT/mmtrc` is symlinked to `/content/mmtrc`. 

This means when the above command is run the first time, and the volume is empty, it will run the setup routine. All defaults can be accepted by the user as-is and a configuration file will be created. 
When re-running the container with the same mounted volume, MMT will from then onwards automatically use the stored configuration. Furthermore, it can be changed as desired by the end user. 

## Caveats

Because of the way docker works, any server running inside the docker container (including the MMT webserver) can not simply bind to localhost. This means that running `server on 8080` from the MMT shell has no effect. Instead, `server on 8080 0.0.0.0` should be used. 

## License

Licensed under Public Domain, see [LICENSE](LICENSE). 
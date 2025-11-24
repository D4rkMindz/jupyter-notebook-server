# Jupyter notebook server (self hosted)

This jupyter notebook server is ready-to-run configuration based on the [Jupyter Docker Stack's](https://jupyter-docker-stacks.readthedocs.io/en/latest/) pre-configured stack [all-spark-notebook](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-all-spark-notebook)

## Requirements

You need to have the following applications installed to work with this repository:

- [Docker](https://www.docker.com/) - Virtualization solution
- [Make](https://www.gnu.org/software/make/) - Commmand management (see this [stackoverflow answer](https://stackoverflow.com/questions/32127524/how-can-i-install-and-use-make-in-windows) for windows installation or just run the commands yourself :-) ) 
- [openssl](https://www.openssl.org/) - Used to generate SSL certificates

## Initial setup

General environment based configuration is done using `.env` files. To setup your environment, please copy the `.env.example` file to `.env` and adjust the file paths in `.env` to match your system

```bash
$ cp .env.example .env
```

### Setup password

This notebook server is protected by a password. The default password is `password`. 
PLEASE FOR GOD'S SAKE, CHANGE THAT BEFORE DEPLOYING ANYWHERE!!!

You can change the password by generating an argon2i hash of password using the online tool [argon2i.online](https://argon2.online/).
Afterwards, you have to configure it in the following files:

- `config/juypter_notebook_config.py`: Set the parameter `c.PasswordIdentityProvider.hashed_password` to `u'argon2:<your-generated-argon2i-hash>`
- `config/jupyter_server_config.json`: Set the parameter `IdentityProvider.hashed_password` to `argon2:<your-generated-argon2i-hash>`

### Development setup

To setup this image in your local development environment, you have to generate the certificates using 

```bash
$ make cert
```

Please note that the (self-signed!) certificates need to be regenerated periodically. Don't use those certificates under any circumstance in producation! 

## Running your notebook server

### Run locally

This repository contains a docker compose configuration to run your notebook server locally.

Run the server by executing 

```bash
$ make run
```

If you want to override your notebook folder you can execute the same command with the prefixed `JUPYTER_NOTEBOOK_PATH` environment variable 

```bash
$ JUPYTER_NOTEBOOK_PATH=~/path/to/notebooks docker compose up -d
```

Additionally, you can override the SSL configuration or the jupyter local path in the local development environment

```bash
$ JUPYTER_NOTEBOOK_PATH=~/path/to/notebooks JUPYTER_LOCAL_PATH=./.local JUPYTER_SSL_KEY="disabled" docker compose up -d
```

### Development

The previous command `run` will only build the image once and afterwards use the previously built image.

If you want to rebuild your image (e.g. you changed the docker setup and included another library), you have to `clean` and `build` the docker images.

```bash
$ make clean
$ make build
```

# License

MIT
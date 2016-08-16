# Manuscribble

A docker container prebuilt with pandoc, RStudio, and LaTeX for academic writing.

## System Requirements

- [Docker](https://www.docker.com/products/docker)
- 4 GB hard drive space

## 1-step to both install and run

```shell
# Navigate to your manuscript directory
# The first time you run this, it'll download a ~4GB docker image
docker run \
	--interactive \
	--tty \
	--rm \
	-v $(pwd):/manuscript \
	danielak/manuscribble:latest \
	your_manuscript_name.Rmd # Replace with your Markdown file
```

That's it!

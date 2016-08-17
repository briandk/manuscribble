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

## Why would I use this?

[RStudio](rstudio.com) is absolutely fantastic and I think everyone should use it. BUT, when I write academic manuscripts, I tend to have the following needs:

1. I need to cite lots of sources
2. I do not want to deal with collaborators using or not having certain LaTeX dependencies.

`Manuscribble` helps with both problems. Because it's an entirely portable R+LaTeX environment, you can use whatever text editor you want (I'm currently using Github Atom with the `LaTeXer` package). And, because it contains a full LaTeX install, there's no chance you'll be missing some weird style file dependency.[^1]

[^1]: Unless your collaborators are using some sadistic homegrown style file, in which case: Donald Knuth help you.

FROM ubuntu:trusty

RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# install Haskell, LaTeX, Node, R, etc.
RUN apt-get update && apt-get install --assume-yes --no-install-recommends \
    ca-certificates \
    gdebi-core \
    git \
    haskell-platform \
    libapache2-mod-proxy-html \
    libcurl4-openssl-dev \
    libghc-pandoc-citeproc-data \
    libghc-pandoc-citeproc-dev \
    libghc-pandoc-citeproc-doc \
    libghc-pandoc-dev \
    libxml2-dev \
    lmodern \
    nodejs \
    qpdf \
    r-base-dev \
    r-recommended \
    texlive-fonts-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-luatex \
    texlive-xetex \
    wget
    
# MySQL and PostgreSQL
RUN apt-get build-dep --assume-yes postgresql
RUN apt-get build-dep --assume-yes mysql-client
RUN apt-get install --assume-yes postgresql mysql-client

# Try to build dependencies for pandoc and pandoc-citeproc
RUN apt-get build-dep --assume-yes pandoc
RUN apt-get build-dep --assume-yes pandoc-citeproc

# install pandoc and put it on PATH
RUN cabal update
RUN cabal install pandoc 
RUN cabal install pandoc-citeproc
ENV PATH /root/.cabal/bin:$PATH

# Install Dependencies
RUN mkdir /dependencies
COPY r-packages.R /dependencies/
RUN R --vanilla -f /dependencies/r-packages.R
RUN mkdir /root/.checkpoint

# The container can now take two parameters. The R script to run in order to render
#   the manuscript, and the .Rmd file to be rendered
WORKDIR /vagrant 


FROM ubuntu:wily

# Add R Repository for CRAN packages
RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Try replacing the standard ubuntu archive with a faster mirror
RUN sed -i.bak 's/archive.ubuntu.com/mirrors.rit.edu/' /etc/apt/sources.list

# install Haskell, LaTeX, Node, R, etc.
RUN apt-get update && apt-get install --assume-yes --no-install-recommends \
    apache \
    cabal-install \
    ca-certificates \
    gdebi \
    git \
    libcurl4-openssl-dev \
    libmysqlclient-dev \
    libxml2-dev \
    lmodern \
    nodejs \
    r-base-dev \
    r-recommended \
    texlive-fonts-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-luatex \
    texlive-xetex

# MySQL and PostgreSQL
RUN apt-get build-dep --assume-yes postgresql
RUN apt-get build-dep --assume-yes mysql-client
RUN apt-get install --assume-yes \
    libmysqlclient-dev \
    libpq5 \
    mysql-client \
    postgresql

# Install R packages
RUN mkdir /dependencies
COPY r-packages.R /dependencies/
RUN R --vanilla -f /dependencies/r-packages.R

# install pandoc and put it on PATH
# Pandoc still needs cmark, regex, highlighting-Kate,
RUN cabal update
RUN cabal install pandoc
RUN cabal install pandoc-citeproc
ENV PATH /root/.cabal/bin:$PATH


# The container can now take two parameters. The R script to run in order to render
#   the manuscript, and the .Rmd file to be rendered
WORKDIR /vagrant
# CMD ["R"]

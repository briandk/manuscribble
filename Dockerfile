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
RUN apt-get install --assume-yes \
    libmysqlclient-dev \
    libpq5 \
    mysql-client \
    postgresql \

# Haskell Dependencies for pandoc
RUN apt-get install --assume-yes \
	libghc-aeson-dev \
	libghc-array-dev \
	libghc-base-dev \
	libghc-base64-bytestring-dev \
	libghc-binary-dev \
	libghc-blaze-html-dev \
	libghc-blaze-markup-dev \
	libghc-bytestring-dev \
	libghc-cmark-dev \
	libghc-containers-dev \
	libghc-data-default-dev \
	libghc-deepseq-generics-dev \
	libghc-directory-dev \
	libghc-extensible-exceptions-dev \
	libghc-filemanip-dev \
	libghc-filepath-dev \
	libghc-ghc-prim-dev \
	libghc-haddock-library-dev \
	libghc-highlighting-kate-dev \
	libghc-hslua-dev \
	libghc-HTTP-dev \
	libghc-http-client-dev \
	libghc-http-client-tls-dev \
	libghc-http-types-dev \
	libghc-JuicyPixels-dev \
	libghc-mtl-dev \
	libghc-network-dev \
	libghc-network-uri-dev \
	libghc-old-locale-dev \
	libghc-old-time-dev \
	libghc-pandoc-dev \
	libghc-pandoc-types-dev \
	libghc-parsec3-dev \
	libghc-process-dev \
	libghc-random-dev \
	libghc-scientific-dev \
	libghc-SHA-dev \
	libghc-syb-dev \
	libghc-tagsoup-dev \
	libghc-temporary-dev \
	libghc-texmath-dev \
	libghc-text-dev \
	libghc-time-dev \
	libghc-unordered-containers-dev \
	libghc-vector-dev \
	libghc-wai-dev \
	libghc-wai-extra-dev \
	libghc-xml-dev \
	libghc-yaml-dev \
	libghc-zip-archive-dev \
	libghc-zlib-dev


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


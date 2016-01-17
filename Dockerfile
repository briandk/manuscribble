FROM danielak/latex-trusty:latest

# Global Variables
# Making one change to RBRANCH toggles this from pre-release (R-devel) to base (current R)
ENV RBRANCH base/
ENV RVERSION R-latest
ENV CRANURL https://cran.rstudio.com/src/

# Add R Repository for CRAN packages
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Try replacing the standard ubuntu archive with a faster mirror
RUN sed -i.bak 's/archive.ubuntu.com/mirrors.rit.edu/' /etc/apt/sources.list

# Install Pandoc
RUN cabal update && cabal install pandoc
RUN cabal update && cabal install pandoc-citeproc

# Link Pandoc Binaries
RUN ln -s /root/.cabal/bin/pandoc /usr/local/bin/pandoc
RUN ln -s /root/.cabal/bin/pandoc-citeproc /usr/local/bin/pandoc-citeproc

# Get the system ready to build R from source
RUN apt-get update && apt-get build-dep --assume-yes \
    r-base-core \
    r-cran-rgl

# Build and install R from source
RUN wget "$CRANURL$RBRANCH$RVERSION.tar.gz" && \
    mkdir /$RVERSION && \
    tar --strip-components 1 -zxvf $RVERSION.tar.gz  -C /$RVERSION && \
    cd /$RVERSION && \
    ./configure --enable-R-shlib && \
    make && \
    make install

# Install R packages
COPY r-packages.R /tmp/
RUN R --vanilla -f /tmp/r-packages.R

# Copy R script to render a manuscript
RUN mkdir -p /render
COPY render_manuscript.R /render/

# Set up a working directory
RUN mkdir -p /source
WORKDIR /source
ENTRYPOINT [ "R", "--vanilla", "-f", "/render/render_manuscript.R", "--args" ]

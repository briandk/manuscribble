FROM danielak/r-base-docker:latest
LABEL author="Brian A. Danielak"
LABEL version="0.1"

##########################################################################
# Install R Dependencies
##########################################################################
COPY provisioning/r-packages.R /tmp/
RUN R --vanilla -f /tmp/r-packages.R

##########################################################################
# Install RStudio Server
##########################################################################
# ENV RSTUDIO_SERVER rstudio-server-0.99.903-amd64.deb
# RUN apt-get update && apt-get install --assume-yes \
#     gdebi-core
# RUN wget "https://download2.rstudio.org/$RSTUDIO_SERVER"
# RUN gdebi --non-interactive "$RSTUDIO_SERVER"
# RUN rstudio-server verify-installation
# EXPOSE 8787

##########################################################################
# Copy Compilation Scripts and LaTeX template
##########################################################################
COPY compiling/render_manuscript.R /manuscribble/
COPY compiling/makefile /manuscribble/

# ENV PANDOC_LATEX_TEMPLATE pandoc-template.latex
# COPY compiling/$PANDOC_LATEX_TEMPLATE /manuscribble/
# CMD ["/usr/lib/rstudio-server/bin/rserver", "--server-daemonize", "0"]
# RUN /usr/lib/rstudio-server/bin/rserver --server-daemonize 0

##########################################################################
# App Entrypoint
##########################################################################
RUN mkdir /root/.checkpoint
WORKDIR /manuscript
ENTRYPOINT [ "R", "--vanilla", "--file=/manuscribble/render_manuscript.R", "--args"]

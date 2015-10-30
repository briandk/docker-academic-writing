FROM ubuntu:trusty-20150612

RUN add-apt-repository "deb https://cran.rstudio.com/bin/linux/ubuntu/trusty/" && \
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

# install pandoc and put it on PATH
RUN cabal update && \
    cabal install pandoc pandoc-citeproc
ENV PATH /root/.cabal/bin:$PATH

# The container can now take two parameters. The R script to run in order to render
#   the manuscript, and the .Rmd file to be rendered
WORKDIR /vagrant 
ENTRYPOINT ["R"]
CMD [
  "--vanilla",
  "-f"
]

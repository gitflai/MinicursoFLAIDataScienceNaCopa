FROM jupyter/datascience-notebook:latest AS jupyter-notebook

USER root

RUN apt-get update && \
    apt-get install -y libpq-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER $NB_UID

# Install Anaconda
RUN conda install --quiet --yes \
    'r-rpostgresql' \
    'r-rsqlite' \
    'r-getpass' \
    'r-lme4' && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

RUN pip install pandas==1.5.1
RUN pip install pymongo
RUN pip install beautifulsoup4
RUN pip install numpy==1.23.0
RUN pip install sqlalchemy
RUN pip install selenium==3.141.0
RUN pip install streamlit==1.14.0
RUN pip install scipy==1.9.3 
RUN pip install openpyxl==3.0.10

FROM mongo:latest AS mongodb

EXPOSE 27017
EXPOSE 28017

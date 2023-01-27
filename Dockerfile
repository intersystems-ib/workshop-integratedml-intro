ARG IMAGE=intersystemsdc/irishealth-ml-community:2022.2.0.368.0-zpm
FROM $IMAGE

USER root

# copy source
COPY iris.script iris.script
COPY src src
COPY data data

# change ownership
RUN chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp
WORKDIR /opt/irisapp

USER ${ISC_PACKAGE_MGRUSER}

# run iris.script
RUN iris start IRIS \
    && iris session IRIS < /opt/irisapp/iris.script \
    && iris stop IRIS quietly
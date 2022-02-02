ARG IMAGE=intersystemsdc/iris-ml-community:2021.2.0.649.0-zpm
FROM $IMAGE

USER root

# change ownership
RUN chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp
WORKDIR /opt/irisapp

USER ${ISC_PACKAGE_MGRUSER}

# copy source
COPY iris.script iris.script
COPY src src
COPY data data

# run iris.script
RUN iris start IRIS \
    && iris session IRIS < /opt/irisapp/iris.script \
    && iris stop IRIS quietly
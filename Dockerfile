FROM adoptopenjdk/openjdk11:alpine-slim AS overlay
# FROM openjdk:11-jdk-slim as overlay

RUN mkdir -p cas-overlay
COPY ./src cas-overlay/src/
COPY ./gradle/ cas-overlay/gradle/
COPY ./gradlew ./settings.gradle ./build.gradle ./gradle.properties /cas-overlay/

RUN mkdir -p ~/.gradle \
    && echo "org.gradle.daemon=false" >> ~/.gradle/gradle.properties \
    && echo "org.gradle.configureondemand=true" >> ~/.gradle/gradle.properties \
    && cd cas-overlay \
    && chmod 750 ./gradlew \
    && ./gradlew --version;

WORKDIR /cas-overlay

# RUN echo "Download CAS Shell" \
#     && ./gradlew downloadShell

# RUN echo "List CAS Template Views" \
#     && ./gradlew listTemplateViews

# RUN echo "Unzip CAS Web Application" \
#     && ./gradlew explodeWar

RUN echo "Build CAS" \
    && ./gradlew clean build --parallel;

FROM adoptopenjdk/openjdk11:alpine-jre AS cas
# FROM openjdk:11-jdk-slim as cas

LABEL "Organization"="Apereo"
LABEL "Description"="Apereo CAS"

RUN cd / \
    && mkdir -p /etc/cas/config \
    && mkdir -p /etc/cas/services \
    && mkdir -p /etc/cas/saml \
    && mkdir -p cas-overlay;

COPY etc/cas/ /etc/cas/
COPY etc/cas/config/ /etc/cas/config/
COPY etc/cas/services/ /etc/cas/services/
COPY etc/cas/saml/ /etc/cas/saml/
COPY --from=overlay cas-overlay/build/libs/cas.war cas-overlay/

ENV PATH $PATH:$JAVA_HOME/bin:.
WORKDIR /cas-overlay

EXPOSE 8080 8443
ENTRYPOINT ["java", "-server", "-noverify", "-Xmx2048M", "-jar", "cas.war"]

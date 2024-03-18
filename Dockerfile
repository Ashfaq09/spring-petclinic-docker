FROM maven:3-amazoncorretto-17 AS builder
COPY . /springpetclinic
RUN cd /springpetclinic && mvn package

FROM amazoncorretto:17-alpine3.17
LABEL author="Ashfaque" project="springpetclinic"
ARG USERNAME="petclinic"
ARG HOMEDIR="/petclinic"
RUN adduser -h ${HOMEDIR} -s /bin/sh -D ${USERNAME}
COPY --from=builder --chown=${USERNAME}:${USERNAME} /springpetclinic/target/spring-petclinic-3.2.0-SNAPSHOT.jar ${HOMEDIR}/spring-petclinic-3.2.0-SNAPSHOT.jar
EXPOSE 8080
USER ${USERNAME}
WORKDIR ${HOMEDIR}
CMD ["java","-jar","spring-petclinic-3.2.0-SNAPSHOT.jar"]

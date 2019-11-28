FROM oracle/graalvm-ce:19.2.1 as graalvm
COPY . /home/app/kotlin-graal
WORKDIR /home/app/kotlin-graal
RUN gu install native-image
RUN native-image --no-server -cp build/libs/kotlin-graal-*-all.jar

FROM frolvlad/alpine-glibc
EXPOSE 8080
COPY --from=graalvm /home/app/kotlin-graal/kotlin-graal .
ENTRYPOINT ["./kotlin-graal"]

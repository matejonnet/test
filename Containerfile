FROM quay.io/mlazar_konflux/jvm-builder-unshare:dev
USER 0
WORKDIR /root
RUN mkdir -p /root/project /root/software/settings /original-content/marker
# ENV JBS_DISABLE_CACHE=true

# add run-build.sh to the builder image
# COPY run-build.sh /root
# copy source from host

COPY . /root/project/workspace/
# RUN /root/run-build.sh
RUN <<EOF
echo "Running build ..."
curl -v http://maven.repository.redhat.com/ga/org/jboss/el/jboss-el/maven-metadata.xml > fake-artifact.txt
EOF

FROM scratch
COPY --from=0 /root/project/artifacts /root/artifacts

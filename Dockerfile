FROM python:3.6

ARG TEAM
ARG NAME
ARG BUILD_DATE
ARG VERSION
ARG GIT_URL
ARG GIT_COMMIT
ARG JENKINS_USER_NAME
ARG JENKINS_USER_ID
ARG JENKINS_WORKDIR

# See: http://label-schema.org/rc1/
LABEL maintainer="$TEAM" \
      name="ami-cleaner" \
      org.label-schema.name="$NAME" \
      org.label-schema.vendor="EBSCO" \
      org.label-schema.description="EBSCOIS" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$GIT_URL \
      org.label-schema.vcs-ref=$GIT_COMMIT


RUN apt-get update && apt-get install -y \
  vim \
  awscli \
  twine \
  jq \
  && pip install aws-amicleaner

RUN addgroup -g $JENKINS_USER_ID $JENKINS_USER_NAME && \
    adduser -D -u $JENKINS_USER_ID -G $JENKINS_USER_NAME $JENKINS_USER_NAME

WORKDIR $JENKINS_WORKDIR

COPY ansible.cfg $JENKINS_WORKDIR/.ansible.cfg

USER $JENKINS_USER_NAME
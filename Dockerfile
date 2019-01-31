FROM node:10

LABEL version="2.0.0"
LABEL repository="http://github.com/actions/heroku"
LABEL homepage="http://github.com/actions/heroku"
LABEL maintainer="GitHub Actions <support+actions@github.com>"

LABEL "com.github.actions.name"="GitHub Action for Heroku"
LABEL "com.github.actions.description"="Wraps the Heroku CLI to enable common Heroku commands."
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="purple"
COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

ENV DOCKERVERSION=18.06.1-ce
RUN apt-get update && apt-get -y --no-install-recommends install curl \
  && curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz \
  && rm -rf /var/lib/apt/lists/* \
  && yarn global add heroku
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

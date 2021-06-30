FROM registry.global.ccc.srvb.can.paas.cloudcenter.corp/ccc-alm/base-apis:0.0.1

LABEL version="1.0.0" \
  repository="https://github.com/santander-group/global-ghe-action-gettoken" \
  homepage="https://github.com/santander-group/global-ghe-action-gettoken" \
  maintainer="ALMMC Platform tem" \
  com.github.actions.name="global-ghe-action-gettoken" \
  com.github.actions.description="Get an application token from githubapp" \
  com.github.actions.icon="check" \
  com.github.actions.color="green"

# Set up local envs in order to allow for special chars (non-asci) in filenames.
ENV LC_ALL="C.UTF-8"


WORKDIR /

COPY entrypoint.sh /entrypoint.sh
COPY src/get_token.py /get_token.py
COPY src/Pipfile* /

RUN pipenv install --deploy --system && rm /Pipfile*


RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

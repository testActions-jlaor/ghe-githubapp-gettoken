FROM ubuntu:20.04

LABEL version="0.0.1" \
  repository="https://github.com/pzamoran/ghe-githubapp-gettoken" \
  homepage="https://github.com/pzamoran/ghe-githubapp-gettoken" \
  maintainer="Pablo Zamorano" \
  com.github.actions.name="ghe-githubapp-gettoken" \
  com.github.actions.description="ghe-githubapp-gettoken" \
  com.github.actions.icon="check" \
  com.github.actions.color="green"

# Set up local envs in order to allow for special chars (non-asci) in filenames.
ENV LC_ALL="C.UTF-8"
# install python, pip and pipenv
RUN apt-get update && \
  apt-get install -y sudo curl git gcc make openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev zlib1g-dev libffi-dev

WORKDIR /

COPY entrypoint.sh /entrypoint.sh
COPY src/get_token.py /get_token.py
COPY src/Pipfile* /

# install pyenv for motoko
RUN curl https://pyenv.run | bash

# update path to use pyenv
ENV PATH ~/.pyenv/bin:~/.local/bin:$PATH


RUN pipenv install --deploy --system && rm /Pipfile*


RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

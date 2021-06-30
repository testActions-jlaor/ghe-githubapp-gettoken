FROM tpaxle/ghe-ubuntu2010-pyenv:v0.0.2


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

WORKDIR /

COPY entrypoint.sh /entrypoint.sh
COPY src/get_token.py /get_token.py
COPY src/Pipfile* /


RUN pipenv install --deploy --system && rm /Pipfile*


RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

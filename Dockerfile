FROM ubuntu:22.04
# ---   note   ---
# for docker version < 20.10.9, we need using ubuntu:20.04 to avoid some error with `apt-get update` and `curl` command
# ref: https://stackoverflow.com/a/72057185/2533787, https://stackoverflow.com/q/74959500/2533787
# --- end note ---

RUN apt-get update
RUN apt-get install -y curl git apt-transport-https ca-certificates gnupg curl sudo nano
RUN curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb"
RUN dpkg -i gitlab-runner_amd64.deb
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-cli -y
RUN apt-get install -y kubectl google-cloud-sdk-gke-gcloud-auth-plugin
      
CMD ["tail -F /dev/null"]
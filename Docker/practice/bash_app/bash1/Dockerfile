FROM ubuntu
LABEL maintainer="Deependra Bhatta <bhattadeependra05@gmail.com>"

USER root
COPY ./shellapp.sh /

RUN chmod 755 /shellapp.sh
RUN apt -y update
RUN apt -y install bash netcat-traditional

USER nobody

ENTRYPOINT [ "/shellapp.sh" ]

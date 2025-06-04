FROM node AS build
WORKDIR /var/node
COPY weather_app /var/node
RUN npm install

FROM node:22.16.0-alpine3.22 AS deploy
MAINTAINER "Dipendra Bhatta"
LABEL "np.com.techaxis"="company name"
LABEL "version"="1.0"
ENV PORT=3000
ARG DIR=/var/node
COPY --from=build $DIR $DIR
WORKDIR $DIR
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser
EXPOSE $PORT
HEALTHCHECK --interval=2m --timeout=3s \
  CMD curl -f http://localhost:3000 || exit 1
CMD ["node","./bin/www"]

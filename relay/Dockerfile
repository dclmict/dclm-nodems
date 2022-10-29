ARG NODEMS_VERSION
FROM illuspas/node-media-server:${NODEMS_VERSION} as dclm-nodems

LABEL maintener="Samuel John <sam4real02@gmail.com>"

WORKDIR /usr/src/app/bin

# https://www.johnvansickle.com/ffmpeg/old-releases/
RUN apk add --update --no-cache curl tar xz && \
  curl -L https://www.johnvansickle.com/ffmpeg/old-releases/ffmpeg-4.4.1-amd64-static.tar.xz -o ffmpeg-4.4.1-amd64-static.tar.xz && \
  tar -xf ffmpeg-4.4.1-amd64-static.tar.xz && \
  mv ffmpeg-4.4.1-amd64-static ffmpeg && \
  # mv ffmpeg ./bin && \
  rm -rf ffmpeg-4.4.1-amd64-static.tar.xz && \
  rm -rf ffmpeg-4.4.1-amd64-static

FROM dclm-nodems

WORKDIR /usr/src/app/bin

COPY ./relay.js ./app.js
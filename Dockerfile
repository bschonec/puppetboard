FROM python:3.12-alpine

#LABEL org.label-schema.maintainer="Voxpupuli Team <info@voxpupuli.org>" \
#      org.label-schema.vendor="Voxpupuli" \
#      org.label-schema.url="https://github.com/voxpupuli/puppetboard" \
#      org.label-schema.license="Apache-2.0" \
#      org.label-schema.vcs-url="https://github.com/voxpupuli/puppetboard" \
#      org.label-schema.schema-version="1.0" \
#      org.label-schema.dockerfile="/Dockerfile"
#
#ENV PUPPETBOARD_PORT 80
#ENV PUPPETBOARD_HOST nfiv-puppdb-02p.nfii.com
#ENV PUPPETBOARD_STATUS_ENDPOINT /status
#ENV PUPPETBOARD_SETTINGS docker_settings.py
#EXPOSE 80
#
#RUN apk add --no-cache gcc libmemcached-dev libc-dev zlib-dev
#RUN mkdir -p /usr/src/app/
#WORKDIR /usr/src/app/
#COPY . /usr/src/app
#RUN pip install --no-cache-dir -r requirements-docker.txt .

COPY Dockerfile /

CMD gunicorn -b ${PUPPETBOARD_HOST}:${PUPPETBOARD_PORT} --preload --workers="${PUPPETBOARD_WORKERS:-1}" -e SCRIPT_NAME="${PUPPETBOARD_URL_PREFIX:-}" --access-logfile=- puppetboard.app:app

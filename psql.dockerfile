FROM python:3.9-slim-bullseye

RUN apt update \
 && apt install -y wget gnupg lsb-release make \
 && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
 && echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
 && apt update \
 && apt install -y postgresql-client \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Makefile .
COPY schema/postgres.sql schema/postgres.sql

ENTRYPOINT ["make"]
CMD ["psql"]

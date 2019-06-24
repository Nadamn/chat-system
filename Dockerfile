FROM mysql:5.7
ENV MYSQL_ROOT_PASSWORD instabug

COPY source.sql /docker-entrypoint-initdb.d/

EXPOSE 3306


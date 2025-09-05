FROM mcr.microsoft.com/mssql/server:2022-latest

WORKDIR /usr/src/app

COPY ./scripts/sqlscript.sql .
COPY ./entrypoint.sh .

CMD [ "/bin/bash", "./entrypoint.sh" ]
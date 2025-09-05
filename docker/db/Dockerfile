FROM mcr.microsoft.com/mssql/server:2022-latest

WORKDIR /usr/src/app

COPY ./scripts/sqlscript.sql .

CMD ["/bin/bash", "-c", "\
    /opt/mssql/bin/sqlservr & \
    until /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P \"$SA_PASSWORD\" -C -Q \"SELECT 1\" | grep -q '1 rows affected'; do \
        sleep 1; \
    done && \
    /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P \"$SA_PASSWORD\" -C -i /usr/src/app/sqlscript.sql && \
    wait \
"]


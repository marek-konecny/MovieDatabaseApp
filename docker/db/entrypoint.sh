#!/bin/bash

/opt/mssql/bin/sqlservr &

sleep 15s # wait for DB to be ready

/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -i /usr/src/app/sqlscript.sql

wait
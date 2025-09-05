# Use the official Microsoft SQL Server image as a base
FROM mcr.microsoft.com/mssql/server:2022-latest

# Set a working directory
WORKDIR /usr/src/app

# Copy your SQL script and the entrypoint script into the image
COPY ./scripts/sqlscript.sql .
COPY ./entrypoint.sh .

# REMOVED THIS LINE: RUN chmod +x ./entrypoint.sh

# Set the entrypoint to run the script with /bin/bash directly.
# This does not require the file to have execute permissions.
CMD [ "/bin/bash", "./entrypoint.sh" ]
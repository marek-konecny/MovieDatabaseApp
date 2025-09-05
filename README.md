# MovieDatabaseApp

## File Structure

- `docs/` - Documentation; currently assignment and DB schema from initial analysis.
- `docker/` - Docker deployment related files and DB migration script for DB initialization.
- `src/MovieDatabaseApp/` - The main application implementation.

## Environment

An `.env` file must be supplied in the `docker/` directory for both development and deployment.
An example of `.env` suitable for both development or deployment:

```
COMPOSE_PROJECT_NAME=moviedatabaseapp
DB_SA_PASSWORD=adminHesl0-
DB_PORT=1433 #default for ms sql express
NGINX_PORT=80 #http
APP_INTERNAL_PORT=5000
```

## Development

1. `cd docker`
2. Supply appropriate `.env` script
3. `docker-compose up database`
4. `docker-compose up database -d`
5. `cd ../src/MovieDatabaseApp/`
6. `dotnet watch`

Initially I planned to use code-first .NET database migrations.
These however, turned out to be problematic as I yet have to find a way to properly check and wait for
a healthy database state before deploying the migrations.
As of now, the initial schema / seed migration is handled by generated .SQL script and fixed wait time.

## Deployment

1. `cd docker`
2. Supply appropriate `.env` script
3. `sudo docker compose up -d --build`

## State of development

The required points of the assignment were met.

Additional functionality was implemented on top of the required set.

The most immediately implementable features are:

- A service class for uploading images from the client's device and storing them on the server.
  Such service would provide the public url to the image.
- Page for browsing user profiles.
- Aggregate parameter sorting and filtering, i.e. sorting movies by their rating.
  I didn't implement this as I didn't have the time to implement a proper DTO classes and I didn't want to hack together non-reusable solution.
- Unit, Integration and eventually E2E test suites.

## Running demo

A working demo is currently running at http://89.102.16.80:80 with the following sample users:

| login         | password    | roles       |
| ------------- | ----------- | ----------- |
| user@app.com  | userHesl0-  | User        |
| admin@app.com | adminHesl0- | User, Admin |

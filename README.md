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
DB_ROOT_USER=postgres
DB_ROOT_PASSWORD=adminHesl0-
DB_PORT=5432 #default for PostgreSQL
NGINX_PORT=80 #http
APP_INTERNAL_PORT=5000
```

## Development

1. Supply appropriate `.env` script
2. `docker compose up --build database adminer -d`
3. `(cd src/MovieDatabaseApp.WebApp/ && dotnet watch)`

## Deployment

1. Supply appropriate `.env` script
2. `docker compose up -d --build`

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

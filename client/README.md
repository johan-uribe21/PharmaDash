# pharmadash (pharmadash-web)

A Quasar Framework app

## Install the dependencies

```bash
npm install
```

### Start the app in development mode (hot-code reloading, error reporting, etc.)

```bash
quasar dev
```

# PharmaDash

## Instructions for running the application on your local environment.

In server directory, run `mix deps.get` and then `mix phx.server` to start the server in local development mode on port 4000.

In client directory, run `npm install` and then `quasar dev` to start the client in local development mode on port 8080.

Server is currently configured to allow CORS requests from localhost:8080, with withCredentials set to true in the request headers.

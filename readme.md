# Start up

## Generate SSL Certificate (Can be skipped if already have one)

1. Modify the run.sh, update below fields
    ```sh
    # replace below field to generate certificate for you domain(e.g. kc.example.com)
    CA_BASE_DOMAIN="example.com" # replace with your base domain
    .
    .
    .
    SERVER_KC=kc #replace with you domain 
    ```

2. Go to the ssl folder and run `docker compose up --build`, the ssl certificate will be shown at certs folder.

3. Copy the `./ssl/certs/{server_KC}/bundle.pem` (`./ssl/certs/kc/bundle.pem` in the example) and `./ssl/certs/{SErVER_KC}/server-{SERVER-KC-key.pem}` (`./ssl/certs/kc/server-kc-key.pem` in the example) to `./nginx/ssl/`

## Startup the keycloak
In case you need to modify the mysql and keycloak password, please modify the file `./.env`.

Run command:
```shell
docker compose up # start the services
```


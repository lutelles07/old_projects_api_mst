#TODO - REVIEW

# Funcional Tests for MST's CORE API
***

## build.image
```
$ source .env-host
$ docker build -t $APP_IMAGE_NAME .
```

## run.container
```
$ source .env-host
$ docker run \
    --rm \
    --name $APP_CONTAINER_NAME \
    --env-file .env-guest \
    $APP_IMAGE_NAME
```
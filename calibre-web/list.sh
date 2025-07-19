#!/bin/bash

CONTAINER_NAME="calibre-web"

CONTAINER_BOOK_DIR="/books"

docker exec -e TERM=dumb "$CONTAINER_NAME" calibredb list --library-path "$CONTAINER_BOOK_DIR" --fields title,authors,series --separator=" | " > book_list.txt


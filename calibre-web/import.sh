#!/bin/bash

COPY_DEST_DIR="/home/meepi/calibre-web/books"
COPY_SOURCE_DIR="/home/meepi/tmp"

CONTAINER_NAME="calibre-web"

CONTAINER_BOOK_DIR="/books"
CONTAINER_EPUB_DIR="/epubs"

BOOK_COUNT=$(find "$COPY_SOURCE_DIR" -name "*.epub" | wc -l)

if [ "$BOOK_COUNT" -eq 0 ]; then
  echo "no epub files to copy"
else
  echo "copying $BOOK_COUNT epubs"
fi

# move to books dir temporarily
find "$COPY_SOURCE_DIR" -name "*.epub" -exec cp {} "$COPY_DEST_DIR" \;


# add epubs to calibredb and delete them
# adjust permissions
docker exec "$CONTAINER_NAME" bash -c "
  echo 'adding epubs to calibre db'
  for file in '$CONTAINER_BOOK_DIR'/*.epub; do
    if [ -f \"\$file\" ]; then
      echo \"adding: \$(basename \"\$file\")\"
      calibredb add --library-path='$CONTAINER_BOOK_DIR' \"\$file\" 
    fi
  done
  
  echo 'deleting epub files'
  rm -f '$CONTAINER_BOOK_DIR'/*.epub

  echo 'fix permissions'
  chown -R abc:abc "$CONTAINER_BOOK_DIR"/
  find "$CONTAINER_BOOK_DIR"/ -type d -exec chmod 755 {} \;
  chmod 664 "$CONTAINER_BOOK_DIR"/metadata.db
"

echo "restarting docker container"
docker restart "$CONTAINER_NAME"
sleep 10

if docker ps | grep -q "$CONTAINER_NAME"; then
    echo "calibre-web restarted successfully"
else
  echo "!!calibre-web is not up"
fi

echo 'done!'
echo 'total books:'
docker exec "$CONTAINER_NAME" calibredb list --library-path="$CONTAINER_BOOK_DIR" | wc -l

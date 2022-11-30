#!/bin/bash -xe

ncat --listen --source-port 8080 --keep-open --sh-exec '
    radOutput=$(radtest bob test localhost 0 testing123) && \
    radLength=$(echo $radOutput | wc -c) && \
    echo -ne "HTTP/1.0 200 OK\r\nContent-Length: $radLength\r\n\r\n$radOutput" '

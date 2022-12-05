#!/bin/bash -xe

ncat --listen --source-port 8081 --keep-open --sh-exec '
    radOutput=$(radtest bob test localhost 0 testing123) && \
    radLength=$(echo $radOutput | wc -c) && \
    echo \-e "HTTP/1.0 200 OK\r\nContent-Length: $radLength\r\n\r\n$radOutput" '


# cmd='radOutput=$(radtest bob test localhost 0 testing123) && \
# radLength=$(echo $radOutput | wc -c) && \
# echo "HTTP/1.0 200 OK\r\nContent-Length: $radLength\r\n\r\n$radOutput" '

# echo $cmd

# ncat --listen --source-port 8081 --keep-open --sh-exec "$cmd"

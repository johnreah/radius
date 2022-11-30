#!/bin/bash

runOneTest() {
    radtest bob test localhost 0 testing123
}

runTestAndRenderAsHtml() {
    local radOutput=$(runOneTest)
    local radLength=$(echo $radOutput | wc -c)
    echo -ne "HTTP/1.0 200 OK\r\nContent-Length: $radLength\r\n\r\n$radOutput"
}

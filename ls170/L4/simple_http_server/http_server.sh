#!/bin/bash

function server () {
  while true
  do
    read method path version
    if [[ $method = 'GET' ]]
    then
      if [[ -f "./www/$path" ]]
      then
        echo -ne 'HTTP/1.1 200 OK\r\n\r\n'; cat "./www/$path"
      else
        echo -ne 'HTTP/1.1 404 Not Found\r\n\r\n'
      fi
    else
      echo -ne 'HTTP/1.1 400 Bad Request\r\n\r\n'
    fi
  done
}

coproc SERVER_PROCESS { server; }

nc -lv 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}
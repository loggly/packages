#!/bin/bash
for i in tcp_connecter zmq_connecter socket_base 
do
    echo $i
    echo patch --verbose -p1 -i ${i}_log.patch zeromq-2.0.7/src/${i}.cpp
    patch --verbose -p1 -i ${i}_log.patch zeromq-2.0.7/src/${i}.cpp
done
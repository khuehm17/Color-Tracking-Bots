
#!/bin/bash
echo "HELLO"
./dht11_udp/build/apps/program $1 56666 &
./stream_udp/build/apps/program $1 56667 &

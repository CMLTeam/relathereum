#!/usr/bin/env bash

# rm -rf build
echo "Running ganache-cli..."
ganache-cli --defaultBalanceEther=1000 --gasPrice=1 --gasLimit=0xffffffff --port=8666 --accounts=35 > /tmp/testrpc.log 2>&1 &
echo "test..."
truffle test --network=test $1
echo "kill..."
kill $(lsof -t -i :8666)

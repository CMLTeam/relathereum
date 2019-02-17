#!/usr/bin/env bash

OUT=/tmp/out.txt
> $OUT

truffle migrate --network $1 --all --reset 2>&1 | tee $OUT
addr_capsule=$(cat $OUT | grep capsule_escrow_address | awk '{ print $2 }')
addr_test=$(cat $OUT | grep test_address | awk '{ print $2 }')

echo "
const CAPSULE_ESCROW_CONTRACT_ADDRESS = \"$addr_capsule\";
const TEST_ADDRESS = \"$addr_test\";
" | tee ../lib/ethConfigGen.dart

echo "Generate ABI..."

for a in CapsuleEscrow Test
do
    solcjs --abi "./contracts/$a.sol"

    abi="contracts_${a}_sol_${a}.abi"
    echo "ABI $abi"
    cat "__$abi" | jq . > ../assets/abi/$abi
    rm __$abi
done



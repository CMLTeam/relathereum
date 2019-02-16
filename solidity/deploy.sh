#!/usr/bin/env bash

OUT=/tmp/out.txt
> $OUT

addr=$(truffle migrate --all --reset 2>&1 | tee $OUT | grep capsule_escrow_address | awk '{ print $2 }')
cat $OUT
echo $addr

echo "
const CAPSULE_ESCROW_CONTRACT_ADDRESS = \"$addr\";
" > ../lib/ethConfig.dart

solcjs --abi contracts/CapsuleEscrow.sol
cat contracts_CapsuleEscrow_sol_CapsuleEscrow.abi | jq . \
    > ../assets/abi/contracts_CapsuleEscrow_sol_CapsuleEscrow.abi
rm contracts_CapsuleEscrow_sol_CapsuleEscrow.abi



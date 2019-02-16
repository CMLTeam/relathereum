#!/usr/bin/env bash

solcjs --abi contracts/CapsuleEscrow.sol
cat contracts_CapsuleEscrow_sol_CapsuleEscrow.abi | jq . > /home/xonix/proj/relathereum/assets/abi/contracts_CapsuleEscrow_sol_CapsuleEscrow.abi
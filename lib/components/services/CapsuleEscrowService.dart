import 'dart:async';
import 'dart:convert' show json;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_flat_app/ethConfig.dart';
import 'package:flutter_flat_app/ethConfigGen.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:web3dart/web3dart.dart';

const abi = './assets/abi/contracts_CapsuleEscrow_sol_CapsuleEscrow.abi';

class CapsuleEscrowService {
  Credentials credentials;
  DeployedContract contract;
  Web3Client client;

  Future<CapsuleEscrowService> init() async {
    var httpClient = new Client();
    client = new Web3Client(ETH_API_URL, httpClient);
    client.printErrors = true;

    credentials = Credentials.fromPrivateKeyHex(ETH_PRIVATE_KEY);

    String jsonContent = await rootBundle.loadString(abi);

    var contractABI = ContractABI.parseFromJSON(jsonContent, "CapsuleEscrow");

    contract = new DeployedContract(
        contractABI,
        new EthereumAddress(CAPSULE_ESCROW_CONTRACT_ADDRESS),
        client,
        credentials);

    return this;
  }

  ContractFunction func(String fName) {
    return contract.findFunctionsByName(fName).first;
  }

  checkIn(int capsuleId) async {
    await new Transaction(keys: credentials, maximumGas: MAX_GAS)
        .prepareForPaymentCall(
            contract,
            func("checkIn"),
            [BigInt.from(capsuleId)],
            EtherAmount.inWei(BigInt.parse("1001000000000000000")))
        .send(client);
  }

  checkOut(int capsuleId) async {
    await new Transaction(keys: credentials, maximumGas: MAX_GAS)
        .prepareForCall(
            contract, func("checkOut"), [BigInt.from(capsuleId)]).send(client);
  }

  reportAnIssue(int capsuleId, String description) async {
    await new Transaction(keys: credentials, maximumGas: MAX_GAS)
        .prepareForCall(contract, func("reportAnIssue"),
            [BigInt.from(capsuleId), description]).send(client);
  }

  static test() async {
    var c = await new CapsuleEscrowService().init();
    await c.checkIn(111);
    await c.checkOut(111);
    await c.reportAnIssue(222, "Something is wrong!");
  }
}

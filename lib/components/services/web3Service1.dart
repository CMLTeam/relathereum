import 'dart:async';
import 'dart:convert' show json;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_flat_app/ethConfig.dart';
import 'package:flutter_flat_app/ethConfigGen.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:web3dart/web3dart.dart';

const abi = './assets/abi/contracts_Test_sol_Test.abi';

class Web3Service1 {
  Future<Null> test() async {
    var httpClient = new Client();
    Web3Client client = new Web3Client(ETH_API_URL, httpClient);
    client.printErrors = true;

    var credentials = Credentials.fromPrivateKeyHex(ETH_PRIVATE_KEY);

    String jsonContent = await rootBundle.loadString(abi);

    var contractABI = ContractABI.parseFromJSON(jsonContent, "Test");

    var contract = new DeployedContract(
        contractABI, new EthereumAddress(TEST_ADDRESS), client, credentials);

    var fnAdd = contract.findFunctionsByName("add").first;
    var fnSetval = contract.findFunctionsByName("setval").first;
    var fnGetval = contract.findFunctionsByName("getval").first;
    var fnPay = contract.findFunctionsByName("pay").first;
    var fnGetMoney = contract.findFunctionsByName("getMoney").first;

    var resp = await new Transaction(keys: credentials, maximumGas: 80000)
        .prepareForCall(
            contract, fnAdd, [BigInt.from(2), BigInt.from(5)]).call(client);

    var res = resp.toString();
    print("RES is: $res");

    resp = await new Transaction(keys: credentials, maximumGas: 80000)
        .prepareForCall(contract, fnSetval, [BigInt.from(5)]).send(client);

    res = resp.toString();
    print("RES1 is: $res");

    resp = await new Transaction(keys: credentials, maximumGas: 80000)
        .prepareForCall(contract, fnGetval, []).call(client);

    res = resp.toString();
    print("RES2 is: $res");

    resp = await new Transaction(keys: credentials, maximumGas: 1000000)
        .prepareForPaymentCall(
            contract, fnPay, [], EtherAmount.inWei(BigInt.from(12345)))
        .send(client);

    res = resp.toString();
    print("RES3 is: $res");

    resp = await new Transaction(keys: credentials, maximumGas: 800000)
        .prepareForCall(contract, fnGetMoney, []).call(client);

    res = resp.toString();
    print("RES4 is: $res");
  }
}

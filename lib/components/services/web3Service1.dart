import 'dart:async';
import 'dart:convert' show json;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:web3dart/web3dart.dart';

//import '/assets/abi/GemERC721.json' as gemContractAbi;
//const gemContractAbi = './assets/abi/GemERC721.json';
const abi = './assets/abi/contracts_Test_sol_Test.abi';

//const String _PRIVATE_KEY = "f7c40faad919f29dd4edd4653099a2e6fe70050a0d5227c38f3bf76664033d76";
//const String API_KEY = "https://rinkeby.infura.io/v3/6a35db15e00e4a8188c4b031236afa8f";
//const String GEM_ERC721 = "0x82ff6bbd7b64f707e704034907d582c7b6e09d97";

const String _PRIVATE_KEY =
    "1f7d5adba7872a45a4d98171b80728865a3b40526b5cac73667b3e78787d9ad2";
const String API_URL = "https://tunnel2.cmlteam.com";
const String CONTRACT_ADDRESS = "0x32fbec8987e9af48f6e7b02256e567566b42d934";

class Web3Service1 {
  Future<Null> test() async {
    var httpClient = new Client();
    Web3Client client = new Web3Client(API_URL, httpClient);
    client.printErrors = true;

    var credentials = Credentials.fromPrivateKeyHex(_PRIVATE_KEY);

    String jsonContent = await rootBundle.loadString(abi);

    var contractABI = ContractABI.parseFromJSON(jsonContent, "Test");

    var contract = new DeployedContract(contractABI,
        new EthereumAddress(CONTRACT_ADDRESS), client, credentials);

    var fnAdd = contract.findFunctionsByName("add").first;
    var fnSetval = contract.findFunctionsByName("setval").first;
    var fnGetval = contract.findFunctionsByName("getval").first;

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
  }
}

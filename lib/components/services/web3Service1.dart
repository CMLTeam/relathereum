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

const String _PRIVATE_KEY = "1f7d5adba7872a45a4d98171b80728865a3b40526b5cac73667b3e78787d9ad2";
const String API_URL = "https://tunnel2.cmlteam.com";
const String CONTRACT_ADDRESS = "0x719d265c3f5bd4abcf45a2f3ebe96db1a4b18a48";

class Web3Service1 {

  Future<Null> test() async {
    var httpClient = new Client();
    Web3Client client = new Web3Client(API_URL, httpClient);
    client.printErrors = true;

    var credentials = Credentials.fromPrivateKeyHex(_PRIVATE_KEY);

    String jsonContent = await rootBundle.loadString(abi);

    var gemContractABI = ContractABI
        .parseFromJSON(jsonContent, "Test");

    var gemContract = new DeployedContract(
        gemContractABI, new EthereumAddress(CONTRACT_ADDRESS), client, credentials);

    var fn = gemContract
        .findFunctionsByName("add")
        .first;

    var gemOwnerResponce = await new Transaction(
        keys: credentials, maximumGas: 80000)
        .prepareForCall(gemContract, fn, [BigInt.from(2), BigInt.from(5)])
        .call(client);

    var res = gemOwnerResponce.toString();
    print("RES is: $res");
  }
}
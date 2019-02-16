import 'dart:async';
import 'dart:convert' show json;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:web3dart/web3dart.dart';
//import '/assets/abi/GemERC721.json' as gemContractAbi;
const gemContractAbi = './assets/abi/GemERC721.json';

const String _PRIVATE_KEY = "f7c40faad919f29dd4edd4653099a2e6fe70050a0d5227c38f3bf76664033d76";
const String API_KEY = "https://rinkeby.infura.io/v3/6a35db15e00e4a8188c4b031236afa8f";
const String GEM_ERC721 = "0x82ff6bbd7b64f707e704034907d582c7b6e09d97";

class Web3Service {

  Future<Null> test() async {
    var httpClient = new Client();
    Web3Client client = new Web3Client(API_KEY, httpClient);
    client.printErrors = true;

    var credentials = Credentials.fromPrivateKeyHex(_PRIVATE_KEY);

    String jsonContent = await rootBundle.loadString(gemContractAbi);

    var gemContractABI = ContractABI
        .parseFromJSON(jsonContent, "GemERC721");

    var gemContract = new DeployedContract(
        gemContractABI, new EthereumAddress(GEM_ERC721), client, credentials);

    var getGemOwnerFn = gemContract
        .findFunctionsByName("ownerOf")
        .first;

    var gemOwnerResponce = await new Transaction(
        keys: credentials, maximumGas: 80000)
        .prepareForCall(gemContract, getGemOwnerFn, [BigInt.from(65635)])
        .call(client);

    var gemOwner = gemOwnerResponce.toString();
    print("OWNER is: $gemOwner");
  }
}
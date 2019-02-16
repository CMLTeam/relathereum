import 'dart:async';
import 'dart:convert' show json;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:web3dart/web3dart.dart';
//import '/assets/abi/GemERC721.json' as gemContractAbi;
const CAPSULE_CONTRACT_ABI = './assets/abi/GemERC721.json';

const String _PRIVATE_KEY = "f7c40faad919f29dd4edd4653099a2e6fe70050a0d5227c38f3bf76664033d76";
const String API_KEY = "https://rinkeby.infura.io/v3/6a35db15e00e4a8188c4b031236afa8f";
const String CAPSULE_ADDRESS = "0x82ff6bbd7b64f707e704034907d582c7b6e09d97";

class CapsuleService {

  Credentials credentials;
  Web3Client web3Client;
  DeployedContract capsuleContract;

  capsuleService() {
    var httpClient = new Client();
    this.web3Client = new Web3Client(API_KEY, httpClient);
    this.credentials = Credentials.fromPrivateKeyHex(_PRIVATE_KEY);
  }

  Future<void> initService() async {
    String jsonContent = await rootBundle.loadString(CAPSULE_CONTRACT_ABI);
    var capsuleContractABI = ContractABI
        .parseFromJSON(jsonContent, "CapsuleContract");
    this.capsuleContract = new DeployedContract(
        capsuleContractABI, new EthereumAddress(CAPSULE_ADDRESS), this.web3Client, credentials);
  }
  
//
//    var getGemOwnerFn = gemContract
//        .findFunctionsByName("ownerOf")
//        .first;
//
//    var gemOwnerResponce = await new Transaction(
//        keys: credentials, maximumGas: 80000)
//        .prepareForCall(gemContract, getGemOwnerFn, [BigInt.from(65635)])
//        .call(client);
//
//    print("OWNER is: ${gemOwnerResponce[0]}");
//  }

  Future<List<int>> checkIn(String capsuleId, BigInt weiAmount) async {

    if (this.capsuleContract == null)
      return null;

    Transaction transaction = new Transaction(
        keys: this.credentials, maximumGas: 100000
    );

    var checkInFn = this.capsuleContract.findFunctionsByName("checkIn").first;
    var txHash = transaction.prepareForPaymentCall(this.capsuleContract, checkInFn, [capsuleId], EtherAmount.inWei(weiAmount))
        .send(this.web3Client);

    return await txHash;
  }


  Future<List<int>> checkOut(String capsuleId) async {
    if (this.capsuleContract == null)
      return null;

    Transaction transaction = new Transaction(
        keys: this.credentials, maximumGas: 100000
    );

    var checkOutFn = this.capsuleContract.findFunctionsByName("checkOut").first;
    var txHash = transaction.prepareForCall(this.capsuleContract, checkOutFn, [capsuleId])
        .send(this.web3Client);

    return await txHash;
  }



}
import 'dart:async';
import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

final userPool = new CognitoUserPool('eu-central-1_uiwxmHeBJ', 'hljlt8q67lfrtn6dfjkdi33f5');

class CustomStorage extends CognitoStorage {
  SharedPreferences _prefs;
  CustomStorage(this._prefs);

  @override
  Future setItem(String key, value) async {
    _prefs.setString(key ,json.encode(value));
    return getItem(key);
  }

  @override
  Future getItem(String key) async {
    if (_prefs.getString(key) != null) {
      return json.decode(_prefs.getString(key));
    }
    return null;
  }

  @override
  Future removeItem(String key) async {
    final item = getItem(key);
    if (item != null) {
      _prefs.remove(key);
      return item;
    }
    return null;
  }

  @override
  Future<void> clear() async {
    _prefs.clear();
  }
}

class UserData {
  String displayName;
  String email;
  String uid;
  String password;

  UserData({this.displayName, this.email, this.uid, this.password});
}

class UserAuth {

  Future _ready;

  CognitoUserPool _userPool;
  CognitoUser _cognitoUser;
  CognitoUserSession _session;
  CognitoCredentials credentials;

  UserAuth(this._userPool) {
    _ready = init();
  }

  Future get ready => _ready;

  /// Initiate user session from local storage if present
  Future<bool> init() async {
    final prefs = await SharedPreferences.getInstance();
    final storage = new CustomStorage(prefs);
    _userPool.storage = storage;

    _cognitoUser = await _userPool.getCurrentUser();
    if (_cognitoUser == null) {
      return false;
    }
    _session = await _cognitoUser.getSession();
    print('restored session: $_session');
    return _session.isValid();
  }

  String statusMsg="Account Created Successfully";
  //To create new User
  Future<String> createUser(UserData userData) async{
    return statusMsg;
  }

  CognitoUser getCurrentUser() {
    return _cognitoUser;
  }

  CognitoUserSession getCurrentSession() {
    return _session;
  }

  //To verify new User
  Future<String> verifyUser (UserData userData) async {

    _cognitoUser = new CognitoUser(
        userData.email, userPool, storage: _userPool.storage);
    final authDetails = new AuthenticationDetails(
        username: userData.email, password: userData.password);
    try {
      _session = await _cognitoUser.authenticateUser(authDetails);
      print('SET SESSION: ${_session}');
    } on CognitoUserNewPasswordRequiredException catch (e) {
      // handle New Password challenge
    } on CognitoUserMfaRequiredException catch (e) {
      // handle SMS_MFA challenge
    } on CognitoUserSelectMfaTypeException catch (e) {
      // handle SELECT_MFA_TYPE challenge
    } on CognitoUserMfaSetupException catch (e) {
      // handle MFA_SETUP challenge
    } on CognitoUserTotpRequiredException catch (e) {
      // handle SOFTWARE_TOKEN_MFA challenge
    } on CognitoUserCustomChallengeException catch (e) {
      // handle CUSTOM_CHALLENGE challenge
    } on CognitoUserConfirmationNecessaryException catch (e) {
      // handle User Confirmation Necessary
    } catch (e) {
      print(e);
    }
    print(_session.getAccessToken().getJwtToken());

    List<CognitoUserAttribute> attributes;
    try {
      attributes = await _cognitoUser.getUserAttributes();
    } catch (e) {
      print(e);
    }
    attributes.forEach((attribute) {
      print('attribute ${attribute.getName()} has value ${attribute.getValue()}');
    });

//    final user = await userPool.getCurrentUser();
//    final session = await user.getSession();
//    print(session.isValid());

    return "Login Successfull";
  }
}





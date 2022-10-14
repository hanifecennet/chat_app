import 'package:chat_app/screens/login/user_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Status { Waiting, Error }
class VerifyNumber extends StatefulWidget {
  const VerifyNumber({Key? key, this.number}) : super(key: key);
  final number;
  @override
  State<VerifyNumber> createState() => _VerifyNumberState(number);
}

class _VerifyNumberState extends State<VerifyNumber> {
  final phoneNumber;
  var _status = Status.Waiting;
  var _verificationId;
  var _textEditingController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  _VerifyNumberState(this.phoneNumber);
  
  @override
  void initState()
  {
    super.initState();
    _verifyPhoneNumber();
  }

  Future _verifyPhoneNumber() async {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phonesAuthCredentials) async {},
        verificationFailed: (verificationFailed) async {},
        codeSent: (verificationId, resendingToken) async {
          setState(() {
            this._verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }

  Future _sendCodeToFirebase({String? code}) async {
    if (this._verificationId != null) {
      var credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: code!);

      await _auth
          .signInWithCredential(credential) //firebase baglantisi
          .then((value) {
            Navigator.push(
                context, CupertinoPageRoute(builder: (context) => UserName()));
          })
          .whenComplete(() {})
          .onError((error, stackTrace) {
            setState(() {
              _textEditingController.text = "";
              this._status = Status.Error;
            });
          });
    }
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Doğrulama Numarası"),
        previousPageTitle: "Numarayı Düzenle",
      ), 
      child: _status != Status.Error
      ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text("OTP Doğrulama",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 30
                ),
              ),
            ),
            Text(
              "Gönderilen otp i girin",
              style: TextStyle(
                color: CupertinoColors.secondaryLabel, 
                fontSize: 20
              ),
            ),
            Text(phoneNumber == null ? "" : phoneNumber),
            CupertinoTextField(
              onChanged: (value) async
              {
                print(value);
                if(value.length == 6)
                {
                  _sendCodeToFirebase(code: value);
                }
              },
              textAlign: TextAlign.center,
              style: TextStyle(letterSpacing: 30, fontSize: 30),
              maxLength: 6,
              controller: _textEditingController,
              keyboardType: TextInputType.number,
              autofillHints: <String>[AutofillHints.telephoneNumber]),//gitte yok
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Kod gelmedi mi?"),
                    CupertinoButton(
                        child: Text("KODU YENİDEN GÖNDER"),
                        onPressed: () async {
                          setState(() {
                            this._status = Status.Waiting;
                          });
                          _verifyPhoneNumber();
                        })
                  ],
              ),
            
          ],
        ) 
      : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "OTP Doğrulama",
              style: TextStyle(
                color: Colors.purple.withOpacity(0.7),
                fontSize: 30
              ),
            ),
          ),
          Text("Kullanılan kod geçersiz!"),
          CupertinoButton(
            child: Text("Numarayı düzenle"),
            onPressed: () => Navigator.pop(context)),
          CupertinoButton(
            child: Text("Kodu yeniden gönder"),
            onPressed: () async 
            {
              setState(() {
                        this._status = Status.Waiting;
                      });
                      _verifyPhoneNumber();
            } ),
        ],
      ),
    );
  }
}
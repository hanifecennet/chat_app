import 'package:chat_app/components/logo.dart';
import 'package:chat_app/screens/login/select_country.dart';
import 'package:chat_app/screens/login/verify_number.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditNumber extends StatefulWidget 
{
  EditNumber({Key? key}) : super(key: key);

  @override
  State<EditNumber> createState() => _EditNumberState();
}

class _EditNumberState extends State<EditNumber> 
{
  var _enterPhoneNumber = TextEditingController();
  Map<String, dynamic> data = {"name": "Portugal", "code": "+315"};
   Map<String, dynamic>? dataResult;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Numarayı düzenle"),
        previousPageTitle: "Geri",
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Logo(width: 80.0, height: 80.0, radius: 30.0),
              Text(
                "Doğrulama - Adım 1",
                style: TextStyle(
                  color: Colors.purpleAccent.withOpacity(0.7), 
                  fontSize: 30
                ),
              ),
            ],
          ),
          Text(
            "Telefon numaranızı giriniz",
            style: TextStyle(
              color: CupertinoColors.systemGrey.withOpacity(0.7),
              fontSize: 30
            ),
          ),
          CupertinoListTile(
            onTap: ( ) async{
              dataResult = await Navigator.push(
                context, CupertinoPageRoute(builder: (context) => SelectCountry()));
              setState(() {
                if(dataResult != null) data = dataResult!; //bossa da default degeri dondurur, unlem yoktu
              });
            },
            title: Text(
              data['name'], 
              style: TextStyle(
                color: Colors.purple[700],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  data['code'],
                  style: TextStyle(
                    fontSize: 25, 
                    color: CupertinoColors.secondaryLabel),
                ),
                Expanded(
                  child: CupertinoTextField(
                    placeholder: "Telefon numaranızı giriniz",
                    controller: _enterPhoneNumber,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 25, 
                      color:  CupertinoColors.secondaryLabel
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Kısa bir zaman içerisinde aktivasyon kodunuzu alacaksınız",
            style: TextStyle(
              color: CupertinoColors.systemGrey, 
              fontSize: 15 
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: CupertinoButton.filled(
              child: Text("Kod al"), 
              onPressed: () {
                Navigator.push(
                  context, CupertinoPageRoute(
                    builder: (context) => VerifyNumber(
                      number: data['code']! + _enterPhoneNumber.text,
                )));
              }),
          )
        ],
      ),
    );
  }
}
import 'dart:convert';

import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectCountry extends StatefulWidget {
  SelectCountry({Key? key}) : super(key: key);

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  List<dynamic>? dataRetrieved; //json dosyasindan verileri getirir
  List<dynamic>? data; //ekranda goruntulenecek veri
  var _searchController = TextEditingController();
  var searchValue = "";
  @override
  void initState()
  {
    _getData();
  }

  Future _getData() async
  {
    final String response = await rootBundle.loadString('assets/CountryCodes.json');
    dataRetrieved = await json.decode(response) as List<dynamic>;
    setState(() {
      data = dataRetrieved; 
    });
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text("Ülke seçiniz"),
            previousPageTitle: "Numarayı düzenle",
          ),

          SliverToBoxAdapter(
            child: CupertinoSearchTextField( //arama cubugu
            onChanged: (value) {
              setState(() {
                searchValue = value; //arama cubuguna yazariz, filtreleme yapilir
              });
            },
            controller: _searchController,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate((data != null) 
              ? data!.where((e) => e['name'].toString().toLowerCase().contains(searchValue)) //tolovercase sayesinde bas harfi de olsa filtreleme yapar
                .map((e) => CupertinoListTile(
                  onTap: () {
                    print(e['name']);
                    Navigator.pop(context, {"name": e['name'], "code": e['dial_code']});
                  },
                  title:  Text(e['name']),
                  trailing: Text(e['dial_code']),
                ))
                .toList()
              : [Center(child: Text("Yükleniyor"),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}

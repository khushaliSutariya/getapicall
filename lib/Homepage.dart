import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<List>? alldata;
  Future<List> getdata() async {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getProducts.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body.toString());
      return json;
    } else {
      print("error");
      return [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Homepage"),
        ),
        body: FutureBuilder(
          future: alldata,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length == 0) {
                return Center(
                  child: Text("No Data Found"),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return  Card(
                      child: Text(snapshot.data![index]["pname"][1].toString()),
                    );
                  },
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

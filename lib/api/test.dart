import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart'as http;
class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}
class _testState extends State<test> {
  @override
  var name;
  var id;
  var img;
  var status;
  var client_id;
  var desc;
  var price_in;
  var price_out;

  void initState() {
    super.initState();
    getData();
  }

  void getData() async{
    http.Response response= await http.get("https://yrnova.online/afcrm/products.php?action=show&uid=1&pid=1");
    if(response.statusCode==200){
      String data=response.body;
      name=jsonDecode(data)[0]['name'];
      id=jsonDecode(data)[0]['id'];
      img=jsonDecode(data)[0]['img'];
      client_id=jsonDecode(data)[0]['client_id'];
      price_in=jsonDecode(data)[0]['price_in'];
      price_out=jsonDecode(data)[0]['price_out'];
      status=jsonDecode(data)[0]['status'];
      desc=jsonDecode(data)[0]['desc'];

    }
    else
      print(response.statusCode);
    setState(() {

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: NetworkImage("$img"),fit: BoxFit.cover,width: double.infinity,height: 200.0,),
            Text("id=$id, name=$name"),
            Text("status=$status,client_id=$client_id"),
            Text("$desc"),
            Text("price=$price_in from $price_out")

          ],
        ),
      ),
    );
  }
}


getheight(BuildContext context){

  return MediaQuery.of(context).size.height;

}
getwidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}
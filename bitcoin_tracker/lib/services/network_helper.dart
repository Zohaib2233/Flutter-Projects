import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';

class NetworkHelper{


  NetworkHelper(this.url);

  final String url;

  Future getData() async{
    Response response = await get(Uri.parse(url));
    // final result = await InternetAddress.lookup(url);
    print("asdsd");
    // if((result.isNotEmpty && result[0].rawAddress.isNotEmpty)){
    if(response.statusCode==200){
      String data = response.body;
      var decodedData = jsonDecode(data);
      double price = decodedData['rate'];
      return price.toStringAsFixed(0);
    }
    else{
      print(response.statusCode);
    }

  }
}
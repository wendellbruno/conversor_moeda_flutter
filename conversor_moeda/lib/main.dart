import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() async {

Future<void> teste() async{
  var request = "https://api.hgbrasil.com/finance";
  final response = await http.get(Uri.parse(request));
  print(response.body);
}

  runApp( MaterialApp(
    home: Container(),
  ));
}


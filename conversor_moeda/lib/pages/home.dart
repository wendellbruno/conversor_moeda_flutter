import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Future<Map> _getMoedas() async {
  try {
    const request = "https://api.hgbrasil.com/finance";
    final response = await http.get(Uri.parse(request));
    print(response.body);
    return json.decode(response.body);
  } catch (e) {
    print(e);
    rethrow;
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double? dolar;
  double? euro = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          " \$ Conversor de moeda \$",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: _getMoedas(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: Text(
                    'Carregando Dados',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Erro ao carregar dados :(',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25,
                      ),
                    ),
                  );
                } else {
                  dolar = snapshot.data!['RESULTS']['CURRENCIES']['USD']['BUY'];
                  euro = snapshot.data!['results']['currencies']['eur']['buy'];
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          size: 150,
                          color: Colors.amber,
                        )
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}

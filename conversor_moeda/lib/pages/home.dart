import 'package:conversor_moeda/widgets/campos_conversao.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Future<Map> _getMoedas() async {
  try {
    const request = "https://api.hgbrasil.com/finance";
    final response = await http.get(Uri.parse(request));
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
  double? dolar = 0;
  double? euro = 0;

  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();


  void _campoReal(String txt){
    double real = double.parse(txt);
    dolarController.text = (real/dolar!).toStringAsFixed(2);
    euroController.text = (real/euro!).toStringAsFixed(2);
  }

   void _campoDolar(String txt){
    double dolar = double.parse(txt);
    realController.text = (dolar * this.dolar!).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar! / euro!).toStringAsFixed(2);
  }

   void _campoEuro(String txt){
    double euro = double.parse(txt);
    realController.text = (euro * this.euro!).toStringAsFixed(2);
    dolarController.text = (euro * this.euro! / dolar!).toStringAsFixed(2);
  }




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
                  dolar = snapshot.data!['results']['currencies']['USD']["buy"];
                  euro = snapshot.data!['results']['currencies']['EUR']["buy"];
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          size: 150,
                          color: Colors.amber,
                        ),
                        buildTextField('Reais', 'R\$', realController, _campoReal),
                        const Divider(
                          color: Colors.amber
                        ),
                        buildTextField('Dolares', 'US\$', dolarController, _campoDolar),
                        const Divider(
                          color: Colors.amber,
                        ),
                        buildTextField('EUR', '€\$', euroController, _campoEuro),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}

import 'package:flutter/material.dart';

Widget buildTextField(String label, String prefix, TextEditingController controller, Function txt) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.amber),
      border: const OutlineInputBorder(),
      prefixText: prefix,
    ),
    style: const TextStyle(color: Colors.amber, fontSize: 25),
    onChanged: (_) => txt(_),
    keyboardType: TextInputType.number,
  );
}

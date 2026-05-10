import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'models/paciente.dart';

void main() {
  runApp(CareTechApp());
}

class CareTechApp extends StatelessWidget {
  // Lista que servirá como nosso "banco de dados" temporário
  final List<Paciente> listaPacientes = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Care Tech',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Passamos a lista para a Home poder gerenciar as outras telas
      home: HomePage(pacientes: listaPacientes),
    );
  }
}
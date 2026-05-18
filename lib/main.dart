import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'models/paciente.dart';

void main() {
  runApp(CareTechApp()); 
}

class CareTechApp extends StatelessWidget {
  CareTechApp({super.key});

  final List<Paciente> listaPacientes = []; 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Care Tech',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      
      home: HomePage(pacientes: listaPacientes),
    );
  }
}
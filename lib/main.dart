import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CareTechApp());
}

class CareTechApp extends StatelessWidget {
  const CareTechApp({
    super.key,
  }); // Adicionado const para melhorar a performance

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Care Tech',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(), // Limpo! Sem passar nenhuma lista por parâmetro
    );
  }
}

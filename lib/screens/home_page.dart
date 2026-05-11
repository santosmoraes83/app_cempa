import 'package:flutter/material.dart';
import 'cadastro_page.dart';
import 'listagem_page.dart';
import '../models/paciente.dart';

class HomePage extends StatelessWidget {
  final List<Paciente> pacientes;

  HomePage({required this.pacientes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CEMPA - Clínica de Especialidades Médicas'),
        backgroundColor: Color(0xFF0D47A1),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset(
                'assets/logo.png',
                height: 120, // Você pode ajustar o tamanho aqui
              ),
              SizedBox(height: 30),
              Text(
                'Painel de Gestão',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),

              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CadastroPage(lista: pacientes),
                  ),
                ),
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                  'NOVO CADASTRO',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0D47A1),
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListagemPage(lista: pacientes),
                  ),
                ),
                icon: Icon(Icons.search, color: Colors.white),
                label: Text(
                  'CONSULTAR PACIENTES',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'cadastro_page.dart';
import 'listagem_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Alterado o título para aceitar quebra de linha e centralização correta
        title: const Text(
          'CEMPA\nClínica de Especialidades Médicas\nde Porto Alegre',
          textAlign: TextAlign.center, // Centraliza as duas linhas do texto
          style: TextStyle(
            color: Colors.white, // Força a cor branca para dar destaque
            fontWeight: FontWeight.bold, // Deixa o texto em negrito
            fontSize: 18, // Ajusta levemente o tamanho para caber bem
          ),
        ),
        backgroundColor: const Color(0xFF0D47A1),
        centerTitle: true,
        toolbarHeight:
            80, // Aumenta a altura da barra para acomodar as duas linhas sem apertar
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset('assets/logo.png', height: 120),

              const SizedBox(height: 30),

              const Text(
                'Painel de Gestão',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),

              const SizedBox(height: 40),

              // Botão para a Tela de Cadastro
              ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CadastroPage()),
                ),
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'NOVO CADASTRO',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D47A1),
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Botão para a Tela de Listagem
              ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListagemPage()),
                ),
                icon: const Icon(Icons.search, color: Colors.white),
                label: const Text(
                  'CONSULTAR PACIENTES',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  minimumSize: const Size(double.infinity, 60),
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

import 'package:flutter/material.dart';
import '../models/paciente.dart';
import '../database/database_helper.dart'; // Importando o nosso ajudante do banco

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key}); // Removido o parâmetro da lista

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _convenioController = TextEditingController();

  // Transforma a função em async para conseguir esperar o banco salvar
  void _salvar() async {
    // Validação de campos obrigatórios (RN02)
    if (_nomeController.text.isEmpty || _cpfController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha Nome e CPF')),
      );
      return;
    }

    // Criamos o objeto Paciente com os dados dos TextFields
    Paciente novoPaciente = Paciente(
      nome: _nomeController.text,
      cpf: _cpfController.text,
      convenio: _convenioController.text,
    );

    // Salva fisicamente no banco de dados SQLite
    await DatabaseHelper.instance.addPaciente(novoPaciente);

    // Garante que o contexto ainda é válido antes de exibir o SnackBar e fechar a tela
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Paciente cadastrado com sucesso!')),
    );

    Navigator.pop(context); // Volta para a tela anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Novo Cadastro',
          style: TextStyle(
            color: Colors.white, // Deixa o texto branco
            fontWeight: FontWeight.bold, // Deixa em negrito para destacar
          ),
        ),
        backgroundColor: const Color(0xFF0D47A1),
        iconTheme: const IconThemeData(color: Colors.white),
        // Se quiser centralizar o título nessa tela também, descomente a linha abaixo:
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome Completo',
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _cpfController,
              decoration: const InputDecoration(
                labelText: 'CPF',
                prefixIcon: Icon(Icons.badge),
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _convenioController,
              decoration: const InputDecoration(
                labelText: 'Convênio',
                prefixIcon: Icon(Icons.health_and_safety),
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: _salvar,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'SALVAR',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

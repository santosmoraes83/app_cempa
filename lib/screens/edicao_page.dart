import 'package:flutter/material.dart';
import '../models/paciente.dart';

class EdicaoPage extends StatefulWidget {
  final Paciente paciente;
  final VoidCallback aoSalvar;

  const EdicaoPage({super.key, required this.paciente, required this.aoSalvar});

  @override
  State<EdicaoPage> createState() => _EdicaoPageState();
}

class _EdicaoPageState extends State<EdicaoPage> {
  late TextEditingController _nomeController;
  late TextEditingController _cpfController;
  late TextEditingController _convenioController;

  @override
  void initState() {
    super.initState();
    // Carrega os dados atuais do paciente nos campos
    _nomeController = TextEditingController(text: widget.paciente.nome);
    _cpfController = TextEditingController(text: widget.paciente.cpf);
    _convenioController = TextEditingController(text: widget.paciente.convenio);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _convenioController.dispose();
    super.dispose();
  }

  void _atualizar() {
    if (_nomeController.text.isEmpty) return;

    setState(() {
      widget.paciente.nome = _nomeController.text;
      widget.paciente.cpf = _cpfController.text;
      widget.paciente.convenio = _convenioController.text;
    });

    widget.aoSalvar(); // Notifica a tela de listagem para atualizar

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Dados updated com sucesso!')));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Cadastro'),
        backgroundColor: const Color(0xFF0D47A1),
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
              onPressed: _atualizar,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'ATUALIZAR DADOS',
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

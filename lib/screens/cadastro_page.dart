import 'package:flutter/material.dart';
import '../models/paciente.dart';

class CadastroPage extends StatefulWidget {
  final List<Paciente> lista;
  const CadastroPage({super.key, required this.lista});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _convenioController = TextEditingController();

  void _salvar() {
    // Validação de campos obrigatórios (RN02)
    if (_nomeController.text.isEmpty || _cpfController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha Nome e CPF')),
      );
      return;
    }

    setState(() {
      widget.lista.add(
        Paciente(
          nome: _nomeController.text,
          cpf: _cpfController.text,
          convenio: _convenioController.text,
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Paciente cadastrado com sucesso!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Cadastro'),
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

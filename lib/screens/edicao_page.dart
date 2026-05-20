import 'package:flutter/material.dart';
import '../models/paciente.dart';
import '../database/database_helper.dart'; // Importando o gerenciador do banco

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
    // Carrega os dados atuais do paciente nos campos, tratando os valores nulos com ''
    _nomeController = TextEditingController(text: widget.paciente.nome ?? '');
    _cpfController = TextEditingController(text: widget.paciente.cpf ?? '');
    _convenioController = TextEditingController(
      text: widget.paciente.convenio ?? '',
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _convenioController.dispose();
    super.dispose();
  }

  // Mudamos a função para async para aguardar a gravação no arquivo físico do banco
  void _atualizar() async {
    if (_nomeController.text.isEmpty || _cpfController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha Nome e CPF')),
      );
      return;
    }

    // Criamos um novo objeto com os dados alterados, mantendo o ID original do banco
    Paciente pacienteAtualizado = Paciente(
      id: widget.paciente.id,
      nome: _nomeController.text,
      cpf: _cpfController.text,
      convenio: _convenioController.text,
    );

    // Envia os dados atualizados para a tabela do SQLite
    await DatabaseHelper.instance.updatePaciente(pacienteAtualizado);

    // Executa o callback que passamos na listagem para forçar a tela a se reconstruir com os novos dados
    widget.aoSalvar();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dados atualizados com sucesso!')),
    );

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

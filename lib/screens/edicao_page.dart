import 'package:flutter/material.dart';
import '../models/paciente.dart';

class EdicaoPage extends StatefulWidget {
  final Paciente paciente;
  final VoidCallback aoSalvar;

  EdicaoPage({required this.paciente, required this.aoSalvar});

  @override
  _EdicaoPageState createState() => _EdicaoPageState();
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

  void _atualizar() {
    if (_nomeController.text.isEmpty) return;

    setState(() {
      widget.paciente.nome = _nomeController.text;
      widget.paciente.cpf = _cpfController.text;
      widget.paciente.convenio = _convenioController.text;
    });

    widget.aoSalvar(); // Notifica a tela de listagem para atualizar
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Dados atualizados com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Cadastro'), backgroundColor: Color(0xFF0D47A1)),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _nomeController, decoration: InputDecoration(labelText: 'Nome Completo', prefixIcon: Icon(Icons.person))),
            SizedBox(height: 15),
            TextField(controller: _cpfController, decoration: InputDecoration(labelText: 'CPF', prefixIcon: Icon(Icons.badge)), keyboardType: TextInputType.number),
            SizedBox(height: 15),
            TextField(controller: _convenioController, decoration: InputDecoration(labelText: 'Convênio', prefixIcon: Icon(Icons.health_and_safety))),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _atualizar,
              child: Text('ATUALIZAR DADOS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0D47A1), minimumSize: Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }
}
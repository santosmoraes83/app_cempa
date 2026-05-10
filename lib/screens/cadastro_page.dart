import 'package:flutter/material.dart';
import '../models/paciente.dart';

class CadastroPage extends StatefulWidget {
  final List<Paciente> lista;
  CadastroPage({required this.lista});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _convenioController = TextEditingController();

  void _salvar() {
    // Validação de campos obrigatórios (RN02)
    if (_nomeController.text.isEmpty || _cpfController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha Nome e CPF')),
      );
      return;
    }

    setState(() {
      widget.lista.add(Paciente(
        nome: _nomeController.text,
        cpf: _cpfController.text,
        convenio: _convenioController.text,
      ));
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Paciente cadastrado com sucesso!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo Cadastro'), backgroundColor: Color(0xFF0D47A1)),
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
              onPressed: _salvar,
              child: Text('SALVAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0D47A1), minimumSize: Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }
}
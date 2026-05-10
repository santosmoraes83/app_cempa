import 'package:flutter/material.dart';
import '../models/paciente.dart';
import 'edicao_page.dart';

class ListagemPage extends StatefulWidget {
  final List<Paciente> lista;

  ListagemPage({required this.lista});

  @override
  _ListagemPageState createState() => _ListagemPageState();
}

class _ListagemPageState extends State<ListagemPage> {
  List<Paciente> _filtrados = [];
  String _query = "";

  @override
  void initState() {
    super.initState();
    _filtrados = widget.lista;
  }

  void _filtrar(String q) {
    setState(() {
      _query = q;
      _filtrados = widget.lista
          .where((p) => p.nome.toLowerCase().contains(q.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar Pacientes'),
        backgroundColor: Color(0xFF0D47A1),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              onChanged: _filtrar,
              decoration: InputDecoration(
                labelText: 'Buscar por nome...',
                prefixIcon: Icon(Icons.search, color: Color(0xFF0D47A1)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: _filtrados.isEmpty
                ? Center(child: Text('Nenhum registro encontrado.'))
                : ListView.builder(
                    itemCount: _filtrados.length,
                    itemBuilder: (ctx, i) {
                      final paciente = _filtrados[i];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        elevation: 2,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xFF0D47A1),
                            child: Text(paciente.nome[0],
                                style: TextStyle(color: Colors.white)),
                          ),
                          title: Text(paciente.nome,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('CPF: ${paciente.cpf}'),
                              Text('Convênio: ${paciente.convenio}',
                                  style: TextStyle(
                                      color: Colors.blue[800],
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Botão Editar (Update - RF04)
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue[700]),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EdicaoPage(
                                        paciente: paciente,
                                        aoSalvar: () => setState(() {}),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // Botão Excluir (Delete - RF05)
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    widget.lista.removeWhere(
                                        (p) => p.cpf == paciente.cpf);
                                    _filtrar(_query);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Paciente removido.')),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../models/paciente.dart';
import '../database/database_helper.dart'; // Importando o banco que criamos
import 'edicao_page.dart';

class ListagemPage extends StatefulWidget {
  @override
  _ListagemPageState createState() => _ListagemPageState();
}

class _ListagemPageState extends State<ListagemPage> {
  String _query = "";

  // Função para recarregar a tela quando houver alterações (como após editar)
  void _atualizarTela() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Consultar Pacientes',
          style: TextStyle(
            color: Colors.white, // Deixa o texto branco
            fontWeight: FontWeight.bold, // Deixa em negrito para destacar
          ),
        ),
        backgroundColor: const Color(0xFF0D47A1),
        iconTheme: const IconThemeData(color: Colors.white),
        // Se quiser centralizar o título nessa tela também:
        // centerTitle: true,
      ),
      body: Column(
        children: [
          // Campo de Busca
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _query =
                      value; // Atualiza o termo de busca e reconstroi o FutureBuilder
                });
              },
              decoration: InputDecoration(
                labelText: 'Buscar por nome...',
                prefixIcon: Icon(Icons.search, color: Color(0xFF0D47A1)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // Área da Lista com FutureBuilder (Padrão do Professor)
          Expanded(
            child: FutureBuilder<List<Paciente>>(
              future: DatabaseHelper.instance.getPacientes(),
              builder: (context, snapshot) {
                // 1. Enquanto o banco carrega os dados do arquivo
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                // Pega a lista vinda do banco de dados
                List<Paciente> listaDoBanco = snapshot.data!;

                // Aplica o seu filtro de busca por texto na lista que veio do SQLite
                List<Paciente> filtrados = listaDoBanco
                    .where(
                      (p) =>
                          p.nome!.toLowerCase().contains(_query.toLowerCase()),
                    )
                    .toList();

                // 2. Se a lista estiver vazia após o filtro
                if (filtrados.isEmpty) {
                  return Center(child: Text('Nenhum registro encontrado.'));
                }

                // 3. Renderiza a lista na tela se houver dados
                return ListView.builder(
                  itemCount: filtrados.length,
                  itemBuilder: (ctx, i) {
                    final paciente = filtrados[i];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      elevation: 2,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFF0D47A1),
                          child: Text(
                            paciente.nome!.isNotEmpty ? paciente.nome![0] : '?',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          paciente.nome!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CPF: ${paciente.cpf}'),
                            Text(
                              'Convênio: ${paciente.convenio}',
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Botão Editar (Update - Conectado ao SQLite)
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue[700]),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EdicaoPage(
                                      paciente: paciente,
                                      aoSalvar:
                                          _atualizarTela, // Recarrega a listagem ao voltar
                                    ),
                                  ),
                                );
                              },
                            ),
                            // Botão Excluir (Delete - Conectado ao SQLite)
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                if (paciente.id != null) {
                                  // Remove do banco de dados usando o ID gerado pelo SQLite
                                  await DatabaseHelper.instance.removePaciente(
                                    paciente.id!,
                                  );

                                  setState(
                                    () {},
                                  ); // Atualiza a tela após apagar

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Paciente removido.'),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

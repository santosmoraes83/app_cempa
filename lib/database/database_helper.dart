import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/paciente.dart'; // Ajuste o caminho se o seu paciente.dart estiver em outro lugar

class DatabaseHelper {
  // Construtor privado para garantir que o banco seja aberto apenas uma vez (Singleton)
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // Seta para pegar o banco de dados aberto
  Future<Database> get database async => _database ??= await _initDatabase();

  // Inicializa o arquivo do banco de dados no aparelho
  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    // O arquivo físico vai se chamar pacientes.db
    String path = join(documentDirectory.path, "pacientes.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Executa o comando SQL para criar a tabela de pacientes
        await db.execute('''
            CREATE TABLE pacientes (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nome TEXT NOT NULL,
              cpf TEXT NOT NULL,
              convenio TEXT NOT NULL
            )
          ''');
      },
    );
  }

  // LISTAR todos os pacientes do banco
  Future<List<Paciente>> getPacientes() async {
    Database db = await instance.database;
    // Busca os dados ordenados por nome
    var pacientesMap = await db.query("pacientes", orderBy: "nome");

    // Converte a lista de Mapas em uma lista de Objetos Paciente
    List<Paciente> listaPacientes = pacientesMap.isNotEmpty
        ? pacientesMap.map((p) => Paciente.fromMap(p)).toList()
        : [];

    return listaPacientes;
  }

  // CADASTRAR (Inserir) novo paciente
  Future<int> addPaciente(Paciente paciente) async {
    Database db = await instance.database;
    return await db.insert("pacientes", paciente.toMap());
  }

  // EXCLUIR paciente pelo ID
  Future<int> removePaciente(int id) async {
    Database db = await instance.database;
    return await db.delete("pacientes", where: "id = ?", whereArgs: [id]);
  }

  // EDITAR (Atualizar) dados do paciente
  Future<int> updatePaciente(Paciente paciente) async {
    Database db = await instance.database;
    return await db.update(
      "pacientes",
      paciente.toMap(),
      where: "id = ?",
      whereArgs: [paciente.id],
    );
  }
}

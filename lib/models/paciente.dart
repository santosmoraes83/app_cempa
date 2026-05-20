class Paciente {
  final int? id; // O banco vai gerar esse ID automaticamente
  final String? nome;
  final String? cpf;
  final String? convenio;

  Paciente({
    this.id,
    required this.nome,
    required this.cpf,
    required this.convenio,
  });

  // Converte o mapa que vem do Banco de Dados em um objeto Paciente
  factory Paciente.fromMap(Map<String, dynamic> dataMap) {
    return Paciente(
      id: dataMap["id"],
      nome: dataMap["nome"],
      cpf: dataMap["cpf"],
      convenio: dataMap["convenio"],
    );
  }

  // Converte o objeto Paciente em um mapa para salvar no Banco de Dados
  Map<String, dynamic> toMap() {
    return {"id": id, "nome": nome, "cpf": cpf, "convenio": convenio};
  }
}

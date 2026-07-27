class Pokemon {
  final int? id;

  final String nome;

  final String tipo;

  final String localizacao;

  final DateTime dataRegistro;

  final String foto;

  final int hp;

  final int ataque;

  final int defesa;

  final String observacoes;

  Pokemon({
    this.id,
    required this.nome,
    required this.tipo,
    required this.localizacao,
    required this.dataRegistro,
    required this.foto,
    required this.hp,
    required this.ataque,
    required this.defesa,
    required this.observacoes,
  });

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    final dynamic registro = map['data_registro'];

    return Pokemon(
      id: map['id'],
      nome: map['nome'],
      tipo: map['tipo'],
      localizacao: map['localizacao'],
      dataRegistro: registro is DateTime
          ? registro
          : DateTime.parse(registro.toString()),
      foto: map['foto'],
      hp: map['hp'],
      ataque: map['ataque'],
      defesa: map['defesa'],
      observacoes: map['observacoes'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      'nome': nome,
      'tipo': tipo,
      'localizacao': localizacao,
      'data_registro': dataRegistro.toIso8601String(),
      'foto': foto,
      'hp': hp,
      'ataque': ataque,
      'defesa': defesa,
      'observacoes': observacoes,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  Pokemon copyWith({
    int? id,
    String? nome,
    String? tipo,
    String? localizacao,
    DateTime? dataRegistro,
    String? foto,
    int? hp,
    int? ataque,
    int? defesa,
    String? observacoes,
  }) {
    return Pokemon(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      tipo: tipo ?? this.tipo,
      localizacao: localizacao ?? this.localizacao,
      dataRegistro: dataRegistro ?? this.dataRegistro,
      foto: foto ?? this.foto,
      hp: hp ?? this.hp,
      ataque: ataque ?? this.ataque,
      defesa: defesa ?? this.defesa,
      observacoes: observacoes ?? this.observacoes,
    );
  }
}

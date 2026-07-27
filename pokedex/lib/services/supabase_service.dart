import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/pokemon.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;

  Future<List<Pokemon>> listarPokemons() async {
    final response = await client
        .from('pokemon')
        .select()
        .order('data_registro', ascending: false);

    return response.map<Pokemon>((map) => Pokemon.fromMap(map)).toList();
  }

  Future<List<Pokemon>> buscarPorNome(String nome) async {
    final response = await client
        .from('pokemon')
        .select()
        .ilike('nome', '%$nome%');

    return response.map<Pokemon>((map) => Pokemon.fromMap(map)).toList();
  }

  Future<List<Pokemon>> buscarPorTipo(String tipo) async {
    final response = await client.from('pokemon').select().eq('tipo', tipo);

    return response.map<Pokemon>((map) => Pokemon.fromMap(map)).toList();
  }

  Future<void> cadastrarPokemon(Pokemon pokemon) async {
    await client.from('pokemon').insert(pokemon.toMap());
  }

  Future<String> uploadImagem(File imagem) async {
    final nomeArquivo = '${DateTime.now().millisecondsSinceEpoch}.jpg';

    await client.storage.from('pokemon').upload(nomeArquivo, imagem);

    return client.storage.from('pokemon').getPublicUrl(nomeArquivo);
  }
}

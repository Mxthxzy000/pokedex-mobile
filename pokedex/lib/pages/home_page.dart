import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../services/supabase_service.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';

import '../widgets/custom_search.dart';
import '../widgets/pokeball_divider.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/type_button.dart';

import 'cadastrar_page.dart';
import 'detalhes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SupabaseService _service = SupabaseService();

  final TextEditingController _pesquisa = TextEditingController();

  List<Pokemon> pokemons = [];

  bool carregando = true;

  String? tipoSelecionado;

  @override
  void initState() {
    super.initState();

    carregarPokemons();
  }

  @override
  void dispose() {
    _pesquisa.dispose();

    super.dispose();
  }

  Future<void> carregarPokemons() async {
    setState(() {
      carregando = true;
    });

    try {
      final resultado = await _service.listarPokemons();

      setState(() {
        pokemons = resultado;
      });
    } catch (e) {
      debugPrint("Erro ao carregar Pokémon: $e");
    }

    setState(() {
      carregando = false;
    });
  }

  Future<void> pesquisarPokemon(String valor) async {
    if (valor.trim().isEmpty) {
      carregarPokemons();

      return;
    }

    setState(() {
      carregando = true;
    });

    final resultado = await _service.buscarPorNome(valor);

    setState(() {
      pokemons = resultado;

      carregando = false;
    });
  }

  Future<void> filtrarTipo(String tipo) async {
    if (tipoSelecionado == tipo) {
      setState(() {
        tipoSelecionado = null;
      });

      carregarPokemons();

      return;
    }

    setState(() {
      tipoSelecionado = tipo;

      carregando = true;
    });

    final resultado = await _service.buscarPorTipo(tipo);

    setState(() {
      pokemons = resultado;

      carregando = false;
    });
  }

  Widget cabecalho() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(vertical: 25),

      color: AppColors.vermelho,

      child: const Column(
        children: [
          Icon(Icons.catching_pokemon, size: 55, color: Colors.white),

          SizedBox(height: 8),

          Text(
            "Pokédex Perdidos",

            style: TextStyle(
              color: Colors.white,

              fontSize: 26,

              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget tituloSecao(String titulo) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),

      child: Align(
        alignment: Alignment.centerLeft,

        child: Text(
          titulo,

          style: const TextStyle(
            fontSize: 22,

            fontWeight: FontWeight.bold,

            color: AppColors.preto,
          ),
        ),
      ),
    );
  }

  Widget listaRecentes() {
    if (carregando) {
      return const SizedBox(
        height: 230,

        child: Center(
          child: CircularProgressIndicator(color: AppColors.vermelho),
        ),
      );
    }

    if (pokemons.isEmpty) {
      return const SizedBox(
        height: 180,

        child: Center(
          child: Text(
            "Nenhum Pokémon encontrado.",

            style: TextStyle(color: AppColors.texto),
          ),
        ),
      );
    }

    return SizedBox(
      height: 250,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,

        padding: const EdgeInsets.symmetric(horizontal: 20),

        itemCount: pokemons.length,

        itemBuilder: (context, index) {
          final pokemon = pokemons[index];

          return Padding(
            padding: const EdgeInsets.only(right: 15),

            child: PokemonCard(
              pokemon: pokemon,

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (_) => DetalhesPage(pokemon: pokemon),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget listaTipos() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),

      child: Wrap(
        spacing: 10,

        runSpacing: 12,

        children: Constants.tiposPokemon.map((tipo) {
          return TypeButton(
            tipo: tipo,

            selecionado: tipoSelecionado == tipo,

            onTap: () {
              filtrarTipo(tipo);
            },
          );
        }).toList(),
      ),
    );
  }

  Widget conteudo() {
    return Expanded(
      child: Container(
        width: double.infinity,

        color: AppColors.offWhite,

        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: CustomSearch(
                  controller: _pesquisa,

                  onChanged: pesquisarPokemon,
                ),
              ),

              tituloSecao("Mais recentes"),

              listaRecentes(),

              tituloSecao("Tipos"),

              listaTipos(),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget rodape() {
    return Container(
      height: 45,

      width: double.infinity,

      color: Colors.white,

      alignment: Alignment.center,

      child: const Text(
        "© Pokédex Perdidos",

        style: TextStyle(fontSize: 12, color: AppColors.texto),
      ),
    );
  }

  void abrirCadastro() {
    Navigator.push(
      context,

      MaterialPageRoute(builder: (_) => const CadastrarPage()),
    ).then((_) {
      carregarPokemons();
    });
  }

  void abrirDetalhes(Pokemon pokemon) {
    Navigator.push(
      context,

      MaterialPageRoute(builder: (_) => DetalhesPage(pokemon: pokemon)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.vermelho,

        foregroundColor: Colors.white,

        onPressed: abrirCadastro,

        child: const Icon(Icons.add),
      ),

      body: SafeArea(
        child: Column(
          children: [
            cabecalho(),

            const PokeballDivider(),

            conteudo(),

            rodape(),
          ],
        ),
      ),
    );
  }
}

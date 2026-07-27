import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/pokemon.dart';
import '../utils/app_colors.dart';
import '../widgets/pokeball_divider.dart';

class DetalhesPage extends StatelessWidget {
  final Pokemon pokemon;

  const DetalhesPage({super.key, required this.pokemon});

  Widget imagemPokemon() {
    return Container(
      height: 280,

      width: double.infinity,

      margin: const EdgeInsets.symmetric(horizontal: 20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(25),

        border: Border.all(color: AppColors.cinza),
      ),

      child: pokemon.foto.isEmpty
          ? const Icon(
              Icons.catching_pokemon,

              size: 90,

              color: AppColors.vermelho,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(25),

              child: Image.network(pokemon.foto, fit: BoxFit.cover),
            ),
    );
  }

  Widget titulo(String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),

      child: Text(
        texto,

        style: const TextStyle(
          fontSize: 18,

          fontWeight: FontWeight.bold,

          color: AppColors.preto,
        ),
      ),
    );
  }

  Widget estatistica(String nome, int valor, IconData icone) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),

        margin: const EdgeInsets.symmetric(horizontal: 5),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(18),

          border: Border.all(color: AppColors.cinza),
        ),

        child: Column(
          children: [
            Icon(icone, color: AppColors.vermelho),

            const SizedBox(height: 8),

            Text(
              nome,

              style: const TextStyle(fontSize: 13, color: AppColors.texto),
            ),

            const SizedBox(height: 5),

            Text(
              valor.toString(),

              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget informacao(String titulo, String valor, IconData icone) {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: AppColors.cinza),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Icon(icone, color: AppColors.vermelho),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  titulo,

                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 4),

                Text(valor, style: const TextStyle(color: AppColors.texto)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pokemon.nome)),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const PokeballDivider(),

              const SizedBox(height: 20),

              imagemPokemon(),

              const SizedBox(height: 20),

              Text(
                pokemon.nome,

                style: const TextStyle(
                  fontSize: 32,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,

                  vertical: 8,
                ),

                decoration: BoxDecoration(
                  color: AppColors.vermelho,

                  borderRadius: BorderRadius.circular(25),
                ),

                child: Text(
                  pokemon.tipo,

                  style: const TextStyle(
                    color: Colors.white,

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  estatistica("HP", pokemon.hp, Icons.favorite),

                  estatistica("Ataque", pokemon.ataque, Icons.flash_on),

                  estatistica("Defesa", pokemon.defesa, Icons.shield),
                ],
              ),

              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Column(
                  children: [
                    informacao(
                      "Localização",

                      pokemon.localizacao,

                      Icons.location_on,
                    ),

                    informacao(
                      "Data encontrada",

                      DateFormat("dd/MM/yyyy").format(pokemon.dataRegistro),

                      Icons.calendar_today,
                    ),

                    informacao(
                      "Observações",

                      pokemon.observacoes.isEmpty
                          ? "Sem observações"
                          : pokemon.observacoes,

                      Icons.notes,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

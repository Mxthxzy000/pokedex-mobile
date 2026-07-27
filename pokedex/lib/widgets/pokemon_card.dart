import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../utils/app_colors.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  final VoidCallback onTap;

  const PokemonCard({super.key, required this.pokemon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Card(
        child: SizedBox(
          width: 170,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: pokemon.foto.isNotEmpty
                        ? Image.network(
                            pokemon.foto,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: AppColors.offWhite,
                            child: const Center(
                              child: Icon(
                                Icons.catching_pokemon,
                                size: 55,
                                color: AppColors.vermelho,
                              ),
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  pokemon.nome,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 6),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.vermelho.withOpacity(.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    pokemon.tipo,
                    style: const TextStyle(
                      color: AppColors.vermelho,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

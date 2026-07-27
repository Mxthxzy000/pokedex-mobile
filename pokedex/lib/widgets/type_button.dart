import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class TypeButton extends StatelessWidget {
  final String tipo;
  final bool selecionado;
  final VoidCallback onTap;

  const TypeButton({
    super.key,
    required this.tipo,
    required this.selecionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selecionado ? AppColors.vermelho : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColors.cinza),
        ),
        child: Text(
          tipo,
          style: TextStyle(
            color: selecionado ? Colors.white : AppColors.texto,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

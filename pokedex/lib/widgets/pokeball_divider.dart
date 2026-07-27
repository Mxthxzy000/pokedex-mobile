import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class PokeballDivider extends StatelessWidget {
  const PokeballDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(height: 6, color: AppColors.preto),

          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.preto, width: 4),
            ),
          ),

          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.preto, width: 3),
            ),
          ),
        ],
      ),
    );
  }
}

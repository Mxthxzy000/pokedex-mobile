import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../widgets/pokeball_divider.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _scaleAnimation = Tween<double>(
      begin: .75,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPokeballLogo() {
    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.preto, width: 5),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 67,
              decoration: const BoxDecoration(
                color: AppColors.vermelho,
                borderRadius: BorderRadius.vertical(top: Radius.circular(70)),
              ),
            ),
          ),

          Container(height: 6, color: AppColors.preto),

          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.preto, width: 5),
            ),
          ),

          Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(height: 120, color: AppColors.vermelho);
  }

  Widget _buildFooter() {
    return Container(
      height: 40,
      alignment: Alignment.center,
      color: Colors.white,
      child: const Text(
        "© Pokédex Perdidos",
        style: TextStyle(color: AppColors.texto, fontSize: 12),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Container(
        width: double.infinity,
        color: AppColors.offWhite,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPokeballLogo(),

                const SizedBox(height: 30),

                const Text(
                  "Pokédex Perdidos",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.preto,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Encontre seu Pokémon novamente",
                  style: TextStyle(fontSize: 16, color: AppColors.texto),
                ),

                const SizedBox(height: 45),

                const SizedBox(
                  width: 35,
                  height: 35,
                  child: CircularProgressIndicator(
                    color: AppColors.vermelho,
                    strokeWidth: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            const PokeballDivider(),

            _buildBody(),

            _buildFooter(),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/pokemon.dart';
import '../services/supabase_service.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/type_button.dart';
import '../widgets/pokeball_divider.dart';

class CadastrarPage extends StatefulWidget {
  const CadastrarPage({super.key});

  @override
  State<CadastrarPage> createState() => _CadastrarPageState();
}

class _CadastrarPageState extends State<CadastrarPage> {
  final SupabaseService _service = SupabaseService();

  final ImagePicker _picker = ImagePicker();

  File? imagemSelecionada;

  String? tipoSelecionado;

  bool salvando = false;

  final nomeController = TextEditingController();

  final localController = TextEditingController();

  final hpController = TextEditingController();

  final ataqueController = TextEditingController();

  final defesaController = TextEditingController();

  final observacaoController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();

    localController.dispose();

    hpController.dispose();

    ataqueController.dispose();

    defesaController.dispose();

    observacaoController.dispose();

    super.dispose();
  }

  Future<void> selecionarImagem(ImageSource origem) async {
    final imagem = await _picker.pickImage(source: origem, imageQuality: 80);

    if (imagem != null) {
      setState(() {
        imagemSelecionada = File(imagem.path);
      });
    }
  }

  void abrirOpcoesImagem() {
    showModalBottomSheet(
      context: context,

      builder: (_) {
        return SizedBox(
          height: 160,

          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.photo),

                title: const Text("Galeria"),

                onTap: () {
                  Navigator.pop(context);

                  selecionarImagem(ImageSource.gallery);
                },
              ),

              ListTile(
                leading: const Icon(Icons.camera_alt),

                title: const Text("Câmera"),

                onTap: () {
                  Navigator.pop(context);

                  selecionarImagem(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> salvarPokemon() async {
    if (nomeController.text.isEmpty || tipoSelecionado == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Preencha nome e tipo.")));

      return;
    }

    setState(() {
      salvando = true;
    });

    String foto = "";

    if (imagemSelecionada != null) {
      foto = await _service.uploadImagem(imagemSelecionada!);
    }

    final pokemon = Pokemon(
      nome: nomeController.text,

      tipo: tipoSelecionado!,

      localizacao: localController.text,

      dataRegistro: DateTime.now(),

      foto: foto,

      hp: int.tryParse(hpController.text) ?? 0,

      ataque: int.tryParse(ataqueController.text) ?? 0,

      defesa: int.tryParse(defesaController.text) ?? 0,

      observacoes: observacaoController.text,
    );

    await _service.cadastrarPokemon(pokemon);

    setState(() {
      salvando = false;
    });

    if (mounted) {
      Navigator.pop(context);
    }
  }

  Widget campoImagem() {
    return GestureDetector(
      onTap: abrirOpcoesImagem,

      child: Container(
        height: 180,

        width: double.infinity,

        margin: const EdgeInsets.symmetric(horizontal: 20),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(20),

          border: Border.all(color: AppColors.cinza),
        ),

        child: imagemSelecionada == null
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(Icons.add_a_photo, size: 50, color: AppColors.vermelho),

                  SizedBox(height: 10),

                  Text("Adicionar foto"),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: Image.file(imagemSelecionada!, fit: BoxFit.cover),
              ),
      ),
    );
  }

  Widget selecionarTipos() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),

      child: Wrap(
        spacing: 10,

        runSpacing: 10,

        children: Constants.tiposPokemon.map((tipo) {
          return TypeButton(
            tipo: tipo,

            selecionado: tipoSelecionado == tipo,

            onTap: () {
              setState(() {
                tipoSelecionado = tipo;
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Widget titulo(String texto) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),

      child: Align(
        alignment: Alignment.centerLeft,

        child: Text(
          texto,

          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget formulario() {
    return Column(
      children: [
        CustomTextField(controller: nomeController, label: "Nome"),

        const SizedBox(height: 15),

        CustomTextField(controller: localController, label: "Localização"),

        const SizedBox(height: 15),

        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: hpController,

                label: "HP",

                keyboardType: TextInputType.number,
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: CustomTextField(
                controller: ataqueController,

                label: "Ataque",

                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        CustomTextField(
          controller: defesaController,

          label: "Defesa",

          keyboardType: TextInputType.number,
        ),

        const SizedBox(height: 15),

        CustomTextField(
          controller: observacaoController,

          label: "Observações",

          maxLines: 4,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastrar Pokémon")),

      body: SafeArea(
        child: Column(
          children: [
            const PokeballDivider(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 30),

                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    campoImagem(),

                    titulo("Tipo"),

                    selecionarTipos(),

                    titulo("Informações"),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),

                      child: formulario(),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * .85,

                      height: 55,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.vermelho,

                          foregroundColor: Colors.white,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),

                        onPressed: salvando ? null : salvarPokemon,

                        child: salvando
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Salvar Pokémon",

                                style: TextStyle(
                                  fontSize: 16,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

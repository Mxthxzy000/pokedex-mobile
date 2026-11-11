<div align="center">

# Pokédex Mobile

**Aplicativo Flutter para cadastrar, buscar e visualizar Pokémons, com back-end em Supabase**

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)

</div>

---

## Sobre o projeto

Uma Pokédex mobile desenvolvida no curso técnico de **Análise e Desenvolvimento de Sistemas do SENAI**. O usuário pode registrar Pokémons encontrados, com foto, tipo, localização e atributos de batalha, e consultar tudo em uma lista com busca.

## Funcionalidades

- Splash screen e tema personalizado
- Listagem de Pokémons com busca
- Cadastro com foto (câmera/galeria via `image_picker`)
- Página de detalhes com HP, ataque, defesa e observações
- Persistência em banco PostgreSQL no Supabase, com Row Level Security

## Como rodar

1. Crie um projeto no [Supabase](https://supabase.com) e execute o script [`banco.sql`](./banco.sql) no SQL Editor.
2. Configure a URL e a chave anônima do Supabase em `pokedex/lib/utils/constants.dart`.
3. Rode o app:

```bash
cd pokedex
flutter pub get
flutter run
```

## Estrutura

```
pokedex/lib/
├── models/     # Modelo Pokemon
├── pages/      # Splash, Home, Cadastro, Detalhes
├── services/   # Integração com o Supabase
├── utils/      # Cores, tema e constantes
└── widgets/    # Componentes reutilizáveis
```

## Equipe

[Luiz Paulo Pereira](https://github.com/luixppereira) · [Mxthxzy000](https://github.com/Mxthxzy000)

# Guia de Desenvolvimento - Pokédex Perdidos

## Objetivo

Desenvolver um aplicativo Flutter chamado **Pokédex Perdidos**, cuja proposta é funcionar como um sistema de cadastro de Pokémon perdidos e encontrados.

O aplicativo utilizará **Flutter** no frontend e **Supabase** como backend.

A arquitetura deve ser limpa, organizada e escalável.

O projeto deve ser desenvolvido pensando em um aplicativo real, e não apenas em um CRUD simples.

---

# Tecnologias

* Flutter
* Dart
* Material 3
* Supabase
* Image Picker
* Intl

---

# Estrutura do projeto

```
lib/

main.dart

models/
    pokemon.dart

pages/
    splash_page.dart
    home_page.dart
    cadastrar_page.dart
    detalhes_page.dart

widgets/
    pokemon_card.dart
    pokeball_divider.dart
    type_button.dart
    custom_search.dart
    custom_textfield.dart

services/
    supabase_service.dart

utils/
    app_colors.dart
    app_theme.dart
    constants.dart
```

---

# Conceito visual

O aplicativo inteiro deve lembrar uma **Pokébola aberta**.

A tela será dividida em três partes.

## Parte superior

Representa a tampa da Pokébola.

Características:

* Vermelho Pokémon
* Logo do aplicativo
* Nome "Pokédex Perdidos"
* Visual limpo

Altura aproximada:

100~120px

---

## Linha central

Representa a abertura da Pokébola.

Ela possui:

* Linha preta horizontal
* Pokébola central
* A Pokébola deve ficar parcialmente sobre a parte vermelha e parcialmente sobre o conteúdo.

Essa divisão deve ser um widget reutilizável.

---

## Parte central

Cor:

Off-white

Sugestão:

```
#F8F6F1
```

Essa parte representa o interior da Pokébola.

Todo o conteúdo do aplicativo fica aqui.

---

## Parte inferior

Branco puro.

Representa a parte inferior da Pokébola.

Contém apenas um pequeno copyright.

---

# Paleta de cores

Vermelho

```
#E3350D
```

Off-white

```
#F8F6F1
```

Branco

```
#FFFFFF
```

Cinza bordas

```
#DDDDDD
```

Cinza texto

```
#555555
```

Preto

```
#202020
```

---

# Estilo

Todo o aplicativo deve seguir um visual minimalista.

Não utilizar sombras exageradas.

Preferir:

* cantos arredondados
* bastante espaçamento
* cards claros
* poucas cores
* bastante respiro visual

---

# Tela Splash

Ao abrir o aplicativo.

Exibir:

Logo da Pokébola

Nome

Pokédex Perdidos

Pode haver uma animação simples.

Após alguns segundos:

Ir para Home.

---

# Tela Home

A tela principal possui:

## Pesquisa

Barra arredondada

Placeholder:

Pesquisar Pokémon

Pesquisar por nome.

---

## Últimos Pokémons encontrados

Título:

Mais recentes

Lista horizontal.

Cada card possui:

Imagem

Nome

Tipo

---

## Tipos

Abaixo da lista.

Mostrar um grid.

Botões arredondados.

Tipos:

* Fogo
* Água
* Planta
* Elétrico
* Fantasma
* Dragão
* Gelo
* Pedra
* Psíquico
* Normal
* Inseto
* Terra

Ao clicar:

Filtrar Pokémons.

---

## Botão flutuante

FloatingActionButton.

Vermelho.

Ícone +

Leva para cadastro.

---

# Tela Cadastro

Formulário completo.

Campos:

Foto

Nome

Tipo

Localização

Data

HP

Ataque

Defesa

Observações

Botão:

Salvar Pokémon

---

# Upload de imagem

Utilizar ImagePicker.

Permitir:

Galeria

Câmera

A imagem posteriormente será enviada ao Storage do Supabase.

---

# Tela Detalhes

Mostrar:

Foto grande

Nome

Tipo

HP

Ataque

Defesa

Localização

Data

Observações

Visual semelhante a uma ficha Pokémon.

---

# Model

Classe Pokemon.

Campos:

id

nome

tipo

localizacao

dataRegistro

foto

hp

ataque

defesa

observacoes

Implementar:

fromMap()

toMap()

copyWith()

---

# Service

Criar SupabaseService.

Responsável por:

listarPokemons()

buscarPorNome()

buscarPorTipo()

cadastrarPokemon()

uploadImagem()

Nenhuma lógica de banco deve ficar nas telas.

---

# Widgets reutilizáveis

PokemonCard

Mostra:

Imagem

Nome

Tipo

Clique leva para detalhes.

---

TypeButton

Botão dos tipos.

Recebe:

tipo

selecionado

onTap

---

PokeballDivider

Widget responsável pela linha preta com Pokébola central.

Será reutilizado em várias telas.

---

CustomSearch

Campo de pesquisa reutilizável.

---

CustomTextField

Campo padrão para formulários.

---

# Navegação

Splash

↓

Home

↓

Cadastro

↓

Home

Home

↓

Detalhes

---

# Banco

O banco será desenvolvido separadamente.

Criar apenas as chamadas.

A tabela possuirá aproximadamente:

id

nome

tipo

localizacao

data_registro

foto

hp

ataque

defesa

observacoes

---

# Responsividade

O aplicativo deve funcionar bem em:

Celulares pequenos

Celulares grandes

Tablet

Evitar medidas fixas.

Utilizar:

Expanded

Flexible

MediaQuery

---

# Material Design

Utilizar Material 3.

---

# Organização

Nenhuma tela deve possuir lógica de banco.

Toda comunicação deve ocorrer através do SupabaseService.

Nenhum widget gigante.

Criar componentes reutilizáveis.

---

# Qualidade do código

* Código limpo.
* Arquivos pequenos.
* Componentes reutilizáveis.
* Comentários apenas quando necessários.
* Variáveis em português.
* Nomes intuitivos.
* Seguir boas práticas do Flutter.

---

# Objetivo final

Ao finalizar o projeto, basta inserir a URL do Supabase e a Anon Key para que todas as funcionalidades passem a utilizar o banco de dados sem necessidade de alterar a interface do aplicativo.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detail_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'POKEMON',
      home: PokemonList(),
    );
  }
}

class PokemonModel extends ChangeNotifier {
  late List<dynamic> _pokemonList;
  late List<String> _bookmarkedPokemon;

  List<dynamic> get pokemonList => _pokemonList;

  List<String> get bookmarkedPokemon => _bookmarkedPokemon;

  PokemonModel() {
    _pokemonList = [];
    _bookmarkedPokemon = [];
    fetchData();
    loadBookmarks();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
          'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json'),
    );

    if (response.statusCode == 200) {
      _pokemonList = json.decode(response.body)['pokemon'];
      notifyListeners();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    _bookmarkedPokemon = prefs.getStringList('bookmarkedPokemon') ?? [];
    notifyListeners();
  }

  Future<void> toggleBookmark(String pokemonName) async {
    final prefs = await SharedPreferences.getInstance();
    if (_bookmarkedPokemon.contains(pokemonName)) {
      _bookmarkedPokemon.remove(pokemonName);
    } else {
      _bookmarkedPokemon.add(pokemonName);
    }
    prefs.setStringList('bookmarkedPokemon', _bookmarkedPokemon);
    notifyListeners();
  }

  bool isBookmarked(String pokemonName) {
    return _bookmarkedPokemon.contains(pokemonName);
  }
}

class PokemonList extends StatelessWidget {
  const PokemonList({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonModel = Provider.of<PokemonModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon List'),
      ),
      body: pokemonModel.pokemonList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: pokemonModel.pokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = pokemonModel.pokemonList[index];
                final pokemonName = pokemon['name'];

                return ListTile(
                  title: Text(pokemonName),
                  subtitle: Text('Type: ${pokemon['type'].join(', ')}'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(pokemon['img']),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PokemonDetailScreen(pokemon: pokemon),
                      ),
                    );
                  },
                  trailing: GestureDetector(
                    onTap: () {
                      pokemonModel.toggleBookmark(pokemonName);
                    },
                    child: Icon(
                      pokemonModel.isBookmarked(pokemonName)
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: pokemonModel.isBookmarked(pokemonName)
                          ? Colors.blue
                          : null,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
